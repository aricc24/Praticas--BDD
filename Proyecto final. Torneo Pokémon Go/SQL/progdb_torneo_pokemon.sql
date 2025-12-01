/**
* Función para crear torneos automáticamente al insertar un nuevo evento.
*/
CREATE OR REPLACE FUNCTION crear_torneos_al_insertar_evento()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO TorneoPelea(Edicion, CantidadAPremiar)
    VALUES (NEW.edicion, 1500.00);

    INSERT INTO TorneoDistanciaRecorrida(Edicion, CantidadAPremiar)
    VALUES (NEW.edicion, 1500.00);

    INSERT INTO TorneoCapturaShinys(Edicion, CantidadAPremiar)
    VALUES (NEW.edicion,1500.00);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
/**
* Trigger para crear torneos al insertar un nuevo evento.
*/
CREATE TRIGGER trigger_crear_torneos
AFTER INSERT ON Evento
FOR EACH ROW
EXECUTE FUNCTION crear_torneos_al_insertar_evento();

/**
* Función para validar que un encargado marcado como jugador
* esté registrado como ParticipanteUNAM.
*/
CREATE OR REPLACE FUNCTION validar_encargado_jugador()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.EsJugador = TRUE THEN
        IF NOT EXISTS (
            SELECT 1
            FROM ParticipanteUNAM P
            WHERE P.Nombre = NEW.Nombre
              AND P.ApellidoPaterno = NEW.ApellidoPaterno
              AND P.ApellidoMaterno = NEW.ApellidoMaterno
              AND P.FechaNacimiento = NEW.FechaNacimiento
              AND P.Sexo = NEW.Sexo
        ) THEN
            RAISE EXCEPTION 'Esta persona no está registrada como ParticipanteUNAM, por lo que no puede ser jugador.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
/**
* Trigger para validar encargado jugador.
*/
CREATE TRIGGER trg_validar_jugador
BEFORE INSERT OR UPDATE ON EncargadoRegistro
FOR EACH ROW
EXECUTE FUNCTION validar_encargado_jugador();

/**
* Función para calcular la distancia entre dos puntos geográficos.
*/
CREATE OR REPLACE FUNCTION distancia_entre_puntos(
    lat1 REAL, lon1 REAL,
    lat2 REAL, lon2 REAL
)
RETURNS DOUBLE PRECISION AS $$
DECLARE
    dlat DOUBLE PRECISION;
    dlon DOUBLE PRECISION;
    a DOUBLE PRECISION;
    c DOUBLE PRECISION;
    R CONSTANT DOUBLE PRECISION := 6371000;
BEGIN
    dlat := radians(lat2 - lat1);
    dlon := radians(lon2 - lon1);

    a := sin(dlat/2)^2
         + cos(radians(lat1)) * cos(radians(lat2)) * sin(dlon/2)^2;

    c := 2 * atan2(sqrt(a), sqrt(1 - a));

    RETURN R * c;
END;
$$ LANGUAGE plpgsql;
/**
* Función para calcular la distancia total recorrida por un entrenador en una edición.
*/
CREATE OR REPLACE FUNCTION distancia_total_entrenador(
    p_edicion INTEGER,
    p_codigo_entrenador INTEGER
)
RETURNS DOUBLE PRECISION AS $$
DECLARE
    total_dist DOUBLE PRECISION := 0;
    lat1 REAL;
    lon1 REAL;
    lat2 REAL;
    lon2 REAL;
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT
            L.Latitud AS lat,
            L.Longitud AS lon
        FROM DistanciaRecorrida D
        JOIN Locacion L ON L.NombreLocacion = D.NombreLocacion
        WHERE D.Edicion = p_edicion
            AND D.CodigoDeEntrenador = p_codigo_entrenador
        ORDER BY D.Fecha, D.Hora
    LOOP
        IF lat1 IS NOT NULL THEN
            total_dist := total_dist +
                distancia_entre_puntos(lat1, lon1, rec.lat, rec.lon);
        END IF;

        lat1 := rec.lat;
        lon1 := rec.lon;
    END LOOP;

    RETURN total_dist; 
END;
$$ LANGUAGE plpgsql;

/**
* Función para contar los pokemones utilizados por un participante en un torneo pelea específico.
*/
CREATE OR REPLACE FUNCTION contar_pokemones_en_torneo_pelea(
    idpersona INTEGER,
    codigoentrenador INTEGER,
    edicion   INTEGER,
    idtorneo  INTEGER
)
RETURNS INTEGER
AS $$
DECLARE pokemones_totales INTEGER;      
BEGIN
    SELECT COUNT(*) INTO pokemones_totales
    FROM Utilizar u
    JOIN Pokemon p ON p.IdPokemon = u.IdPokemon
    WHERE p.IdPersona = idpersona
        AND p.CodigoDeEntrenador = codigoentrenador
        AND u.Edicion = edicion
        AND u.IdTorneo = idtorneo;
    RETURN pokemones_totales;
END;
$$ LANGUAGE plpgsql;

/**
* Función para validar que un participante no registre más de 6 pokemones 
*/
CREATE OR REPLACE FUNCTION validar_limite_pokemones()
RETURNS TRIGGER AS $$
DECLARE
    idPersona INTEGER;
    codigoEntrenador INTEGER;
    total_pokemones INTEGER;
BEGIN
    SELECT IdPersona, CodigoDeEntrenador INTO idPersona, codigoEntrenador
    FROM Pokemon
    WHERE IdPokemon = NEW.IdPokemon;

    total_pokemones := contar_pokemones_en_torneo_pelea(
                            idPersona,
                            codigoEntrenador,
                            NEW.Edicion,
                            NEW.IdTorneo
                        );

    IF total_pokemones >= 6 THEN
        RAISE EXCEPTION
            'El participante (% , %) ha alcanzado el límite de 6 pokemones en el torneo pelea % edición %.',
            idPersona, codigoEntrenador, NEW.IdTorneo, NEW.Edicion;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/**
* Trigger para validar el límite de pokemones por participante en un torneo pelea.
*/
CREATE TRIGGER trg_validar_limite_pokemones
BEFORE INSERT OR UPDATE ON Utilizar
FOR EACH ROW
EXECUTE FUNCTION validar_limite_pokemones();

/**
 * Procedimiento para determinar el ganador de un torneo de pelea
 * basado en el número de peleas ganadas.
 * En caso de empate, se lanza una excepción.
 */
CREATE OR REPLACE PROCEDURE determinar_ganador_torneo_pelea(
    ed INT,
    torneo INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    ganador_id INT;
    ganador_cnt INT;
    empate INT;
BEGIN
    WITH peleas_cuenta AS (
        SELECT IdPersona, CodigoDeEntrenador, COUNT(*) AS cnt
        FROM PeleaTorneo
        WHERE Edicion = ed AND IdTorneo = torneo
        GROUP BY IdPersona, CodigoDeEntrenador
    )
    SELECT IdPersona, cnt
    INTO ganador_id, ganador_cnt
    FROM peleas_cuenta
    ORDER BY cnt DESC
    LIMIT 1;

    IF ganador_id IS NULL THEN
        RAISE EXCEPTION 'No hubo peleas en torneo pelea %, edición %', torneo, ed;
    END IF;

    SELECT COUNT(*) INTO empate
    FROM peleas_cuenta
    WHERE cnt = ganador_cnt;

    IF empate > 1 THEN
        RAISE EXCEPTION 'Empate en torneo pelea %, edición %', torneo, ed;
    END IF;

    UPDATE TorneoPelea
    SET IdPersona = ganador_id
    WHERE Edicion = ed AND IdTorneo = torneo;
END;
$$;

/**
* Procedimiento para determinar el ganador de un torneo de distancia recorrida
* usando la cuenta con mayor distancia total. No actualiza si hay empate.
*/
CREATE OR REPLACE PROCEDURE determinar_ganador_torneo_distancia(
    p_edicion INT,
    p_torneo INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    ganador_id INT;
    max_distancia NUMERIC;
    empate INT;
BEGIN
    WITH distancias_cuenta AS (
        SELECT IdPersona, CodigoDeEntrenador,
                distancia_total_entrenador(p_edicion, CodigoDeEntrenador) AS total_dist
        FROM DistanciaRecorrida
        WHERE Edicion = p_edicion AND IdTorneo = p_torneo
        GROUP BY IdPersona, CodigoDeEntrenador
    )
    SELECT IdPersona, total_dist
    INTO ganador_id, max_distancia
    FROM distancias_cuenta
    ORDER BY total_dist DESC
    LIMIT 1;

    IF ganador_id IS NULL THEN
        RAISE EXCEPTION 'No hubo recorridos en torneo distancia recorrida %, edición %', p_torneo, p_edicion;
    END IF;

    SELECT COUNT(*) INTO empate
    FROM distancias_cuenta
    WHERE total_dist = max_distancia;

    IF empate > 1 THEN
        RAISE EXCEPTION 'Empate en torneo distancia recorrida %, edición %', p_torneo, p_edicion;
    END IF;

    UPDATE TorneoDistanciaRecorrida
    SET IdPersona = ganador_id
    WHERE Edicion = p_edicion AND IdTorneo = p_torneo;
END;
$$;

/**
* Función para contar el número de pokémones shiny capturados por una cuenta en un torneo específico.
*/
CREATE OR REPLACE FUNCTION contar_shinys_cuenta(
    p_edicion INTEGER,
    p_torneo INTEGER,
    p_idpersona INTEGER,
    p_codigo_entrenador INTEGER
)
RETURNS INTEGER
AS $$
DECLARE
    total_shinys INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO total_shinys
    FROM Registrar r
    JOIN Pokemon p ON r.IdPokemon = p.IdPokemon
    WHERE r.Edicion = p_edicion
        AND r.IdTorneo = p_torneo
        AND r.IdPersona = p_idpersona
        AND r.CodigoDeEntrenador = p_codigo_entrenador
        AND p.Shiny = TRUE;

    RETURN total_shinys;
END;
$$ LANGUAGE plpgsql;

/**
* Procedimiento para determinar el ganador de un torneo de captura de shinys.
* En caso de empate, se lanza una excepción.
*/
CREATE OR REPLACE PROCEDURE determinar_ganador_torneo_shiny(
    p_edicion INT,
    p_torneo INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    ganador_id INT;
    max_shinys INT;
    empate INT;
BEGIN
    WITH shinys_cuenta AS (
        SELECT IdPersona, CodigoDeEntrenador,
                contar_shinys_cuenta(p_edicion, p_torneo, IdPersona, CodigoDeEntrenador) AS total_shinys
        FROM Registrar
        WHERE Edicion = p_edicion AND IdTorneo = p_torneo
        GROUP BY IdPersona, CodigoDeEntrenador
    )
    SELECT IdPersona, total_shinys
    INTO ganador_id, max_shinys
    FROM shinys_cuenta
    ORDER BY total_shinys DESC
    LIMIT 1;

    IF ganador_id IS NULL THEN
        RAISE EXCEPTION 'No hubo capturas en torneo captura shiny %, edición %', p_torneo, p_edicion;
    END IF;

    SELECT COUNT(*) INTO empate
    FROM shinys_cuenta
    WHERE total_shinys = max_shinys;

    IF empate > 1 THEN
        RAISE EXCEPTION 'Empate en torneo captura shiny %, edición %', p_torneo, p_edicion;
    END IF;

    UPDATE TorneoCapturaShinys
    SET IdPersona = ganador_id
    WHERE Edicion = p_edicion AND IdTorneo = p_torneo;
END;
$$;

/**
* Función para validar que un participante que se inscribe en un torneo de pelea
* no esté ya inscrito en torneos de distancia recorrida o captura de shinys.
*/
CREATE OR REPLACE FUNCTION validar_pelea_inscripcion()
RETURNS TRIGGER AS $$
DECLARE
    en_otro_torneo INT;
BEGIN
    SELECT COUNT(*) INTO en_otro_torneo
    FROM InscripcionTorneoDistancia
    WHERE IdPersona = NEW.IdPersona
        AND CodigoDeEntrenador = NEW.CodigoDeEntrenador
        AND Edicion = NEW.Edicion;

    IF en_otro_torneo > 0 THEN
        RAISE EXCEPTION 'El participante % (cuenta %) ya está en un torneo de distancia recorrida en la edición % y no puede inscribirse en pelea',
            NEW.IdPersona, NEW.CodigoDeEntrenador, NEW.Edicion;
    END IF;
    
    SELECT COUNT(*) INTO en_otro_torneo
    FROM InscripcionTorneoCaptura
    WHERE IdPersona = NEW.IdPersona
        AND CodigoDeEntrenador = NEW.CodigoDeEntrenador
        AND Edicion = NEW.Edicion;

    IF en_otro_torneo > 0 THEN
        RAISE EXCEPTION 'El participante % (cuenta %) ya está en un torneo de captura de shinys en la edición % y no puede inscribirse en pelea',
            NEW.IdPersona, NEW.CodigoDeEntrenador, NEW.Edicion;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
/**
* Trigger para validar inscripción en torneo de pelea.
*/
CREATE TRIGGER trg_validar_pelea
BEFORE INSERT ON InscripcionTorneoPelea
FOR EACH ROW
EXECUTE FUNCTION validar_pelea_inscripcion();

/**
* Función para validar que un participante que se inscribe en torneos de distancia recorrida
* o captura de shinys no esté ya inscrito en un torneo de pelea.
*/
CREATE OR REPLACE FUNCTION validar_no_pelea_inscripcion()
RETURNS TRIGGER AS $$
DECLARE
    en_pelea INT;
BEGIN
    SELECT COUNT(*) INTO en_pelea
    FROM InscripcionTorneoPelea
    WHERE IdPersona = NEW.IdPersona
        AND CodigoDeEntrenador = NEW.CodigoDeEntrenador
        AND Edicion = NEW.Edicion;

    IF en_pelea > 0 THEN
        RAISE EXCEPTION 'El participante % (cuenta %) ya está en un torneo de pelea en la edición % y no puede inscribirse en otro torneo',
            NEW.IdPersona, NEW.CodigoDeEntrenador, NEW.Edicion;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
/**
* Trigger para validar inscripción en torneo de distancia recorrida
*/
CREATE TRIGGER trg_validar_distancia
BEFORE INSERT ON InscripcionTorneoDistancia
FOR EACH ROW
EXECUTE FUNCTION validar_no_pelea_inscripcion();
/**
* Trigger para validar inscripción en torneo de captura de shinys
*/
CREATE TRIGGER trg_validar_captura
BEFORE INSERT ON InscripcionTorneoCaptura
FOR EACH ROW
EXECUTE FUNCTION validar_no_pelea_inscripcion();