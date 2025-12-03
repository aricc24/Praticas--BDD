
/**
* Función para normalizar cadenas eliminando tildes, diéresis y virguilla
*/
CREATE OR REPLACE FUNCTION quitar_acentos(texto TEXT)
RETURNS TEXT AS $$
BEGIN
    RETURN translate(
        texto,
        'ÁÉÍÓÚáéíóúÜüÑñ',
        'AEIOUaeiouUuNn'
    );
END;
$$ LANGUAGE plpgsql IMMUTABLE;

/**
* Función para validar concordancia entre carrera y facultad de ParticipanteUNAM
*/
CREATE OR REPLACE FUNCTION validar_carrera_facultad()
RETURNS TRIGGER AS $$
DECLARE
    fac TEXT;
    car TEXT;
    carreras_validas TEXT[];
BEGIN
    fac := lower(quitar_acentos(NEW.Facultad));
    car := lower(quitar_acentos(NEW.Carrera));

    CASE fac

        -- =====================================================
        -- FACULTAD DE ARQUITECTURA
        -- =====================================================
        WHEN 'facultad de arquitectura' THEN
            carreras_validas := ARRAY[
                'arquitectura',
                'arquitectura de paisaje',
                'diseno industrial',
                'urbanismo'
            ];

        -- =====================================================
        -- FACULTAD DE ARTES Y DISEÑO
        -- =====================================================
        WHEN 'facultad de artes y diseno' THEN
            carreras_validas := ARRAY[
                'arte y diseno',
                'artes visuales',
                'diseno y comunicacion visual'
            ];

        -- =====================================================
        -- FACULTAD DE CIENCIAS
        -- =====================================================
        WHEN 'facultad de ciencias' THEN
            carreras_validas := ARRAY[
                'actuaria', 'biologia', 'ciencias de la computacion',
                'fisica', 'fisica biomedica', 'matematicas',
                'matematicas aplicadas'
            ];

        -- =====================================================
        -- FACULTAD DE CIENCIAS POLÍTICAS Y SOCIALES
        -- =====================================================
        WHEN 'facultad de ciencias politicas y sociales' THEN
            carreras_validas := ARRAY[
                'antropologia',
                'sociologia',
                'ciencias de la comunicacion',
                'relaciones internacionales'
            ];

        -- =====================================================
        -- FACULTAD DE CONTADURÍA Y ADMINISTRACIÓN
        -- =====================================================
        WHEN 'facultad de contaduria y administracion' THEN
            carreras_validas := ARRAY[
                'administracion',
                'contaduria',
                'informatica',
                'negocios internacionales'
            ];

        -- =====================================================
        -- FACULTAD DE DERECHO
        -- =====================================================
        WHEN 'facultad de derecho' THEN
            carreras_validas := ARRAY[
                'derecho'
            ];

        -- =====================================================
        -- FACULTAD DE ECONOMÍA
        -- =====================================================
        WHEN 'facultad de economia' THEN
            carreras_validas := ARRAY[
                'economia'
            ];

        -- =====================================================
        -- FACULTAD DE ENFERMERÍA Y OBSTETRICIA
        -- =====================================================
        WHEN 'facultad de enfermeria y obstetricia' THEN
            carreras_validas := ARRAY[
                'enfermeria',
                'enfermeria y obstetricia'
            ];

        -- =====================================================
        -- FACULTAD DE ESTUDIOS SUPERIORES ACATLÁN
        -- =====================================================
        WHEN 'facultad de estudios superiores acatlan' THEN
            carreras_validas := ARRAY[
                'actuaria',
                'arquitectura',
                'ciencias politicas y administracion publica',
                'comunicacion',
                'derecho',
                'diseno grafico',
                'economia',
                'ensenanza de espanol como lengua extranjera',
                'ensenanza de ingles como lengua extranjera',
                'filosofia',
                'historia',
                'ingenieria civil',
                'lengua y literaturas hispanicas',
                'matematicas aplicadas y computacion',
                'pedagogia',
                'relaciones internacionales',
                'sociologia'
            ];

        -- =====================================================
        -- FACULTAD DE ESTUDIOS SUPERIORES ARAGÓN
        -- =====================================================
        WHEN 'facultad de estudios superiores aragon' THEN
            carreras_validas := ARRAY[
                'arquitectura',
                'comunicacion y periodismo',
                'derecho',
                'diseno industrial',
                'economia',
                'ingenieria civil',
                'ingenieria electrica electronica',
                'ingenieria en computacion',
                'ingenieria mecanica',
                'ingenieria industrial',
                'planificacion para el desarrollo agropecuario',
                'pedagogia',
                'relaciones internacionales',
                'sociologia'
            ];

        -- =====================================================
        -- FACULTAD DE ESTUDIOS SUPERIORES CUAUTITLÁN
        -- =====================================================
        WHEN 'facultad de estudios superiores cuautitlan' THEN
            carreras_validas := ARRAY[
                'administracion',
                'bioquimica diagnostica',
                'contaduria',
                'diseno y comunicacion visual',
                'farmacia',
                'informatica',
                'ingenieria agricola',
                'ingenieria en alimentos',
                'ingenieria en telecomunicaciones sistemas y electronica',
                'ingenieria industrial',
                'ingenieria mecanica electrica',
                'ingenieria quimica',
                'medicina veterinaria y zootecnia',
                'quimica',
                'quimica industrial',
                'tecnologia'
            ];

        -- =====================================================
        -- FACULTAD DE ESTUDIOS SUPERIORES IZTACALA
        -- =====================================================
        WHEN 'facultad de estudios superiores iztacala' THEN
            carreras_validas := ARRAY[
                'biologia',
                'cirujano dentista',
                'ecologia',
                'enfermeria',
                'medico cirujano',
                'optometria',
                'psicologia'
            ];

        -- =====================================================
        -- FACULTAD DE ESTUDIOS SUPERIORES ZARAGOZA
        -- =====================================================
        WHEN 'facultad de estudios superiores zaragoza' THEN
            carreras_validas := ARRAY[
                'biologia',
                'cirujano dentista',
                'desarrollo comunitario para el envejecimiento',
                'enfermeria',
                'ingenieria quimica',
                'medico cirujano',
                'nutriologia',
                'psicologia',
                'quimica farmaceutico biologica'
            ];

        -- =====================================================
        -- FACULTAD DE FILOSOFÍA Y LETRAS
        -- =====================================================

        WHEN 'facultad de filosofia y letras' THEN
            carreras_validas := ARRAY[
                'administracion de archivos y gestion documental',
                'bibliotecologia y estudios de la informacion',
                'desarrollo y gestion interculturales',
                'estudios latinoamericanos',
                'filosofia',
                'geografia',
                'historia',
                'lengua y literaturas hispanicas',
                'lengua y literaturas modernas',
                'letras clasicas',
                'literatura dramatica y teatro',
                'pedagogia'
            ];

        -- =====================================================
        -- FACULTAD DE INGENIERÍA
        -- =====================================================

        WHEN 'facultad de ingenieria' THEN
            carreras_validas := ARRAY[
                'ingenieria aeroespacial',
                'ingenieria ambiental',
                'ingenieria civil',
                'ingenieria de minas y metalurgia',
                'ingenieria electrica electronica',
                'ingenieria en computacion',
                'ingenieria en sistemas biomedicos',
                'ingenieria en telecomunicaciones',
                'ingenieria geofisica',
                'ingenieria geologica',
                'ingenieria geometrica',
                'ingenieria industrial',
                'ingenieria mecanica',
                'ingenieria mecatronica',
                'ingenieria petrolera'
            ];

        -- =====================================================
        -- FACULTAD DE MEDICINA
        -- =====================================================

        WHEN 'facultad de medicina' THEN
            carreras_validas := ARRAY[
                'ciencia de la nutricion humana',
                'fisioterapia',
                'investigacion biomedica basica',
                'medico cirujano',
                'neurociencias'
            ];

        -- =====================================================
        -- FACULTAD DE MEDICINA VETERINARIA Y ZOOTECNIA
        -- =====================================================
        WHEN 'facultad de medicina veterinaria y zootecnia' THEN
            carreras_validas := ARRAY[
                'medicina veterinaria y zootecnia'
            ];

        WHEN 'facultad de musica' THEN
            carreras_validas := ARRAY[
                'etnomusicologia',
                'musica - canto',
                'musica - composicion',
                'musica - educacion musical',
                'musica - instrumentista',
                'musica - piano'
            ];

        -- =====================================================
        -- FACULTAD DE ODONTOLOGÍA
        -- =====================================================

        WHEN 'facultad de odontologia' THEN
            carreras_validas := ARRAY[
                'cirujano dentista'
            ];

        -- =====================================================
        -- FACULTAD DE PSICOLOGÍA
        -- =====================================================

        WHEN 'facultad de psicologia' THEN
            carreras_validas := ARRAY[
                'psicologia'
            ];

        -- =====================================================
        -- FACULTAD DE QUÍMICA
        -- =====================================================

        WHEN 'facultad de quimica' THEN
            carreras_validas := ARRAY[
                'ingenieria quimica',
                'ingenieria quimica metalurgica',
                'quimica',
                'quimica de alimentos',
                'quimica e ingenieria en materiales',
                'quimica farmaceutico biologica'
            ];

        -- =====================================================
        -- ESCUELA NACIONAL DE ESTUDIOS SUPERIORES UNIDAD JURIQUILLA
        -- =====================================================
        WHEN 'escuela nacional de estudios superiores unidad juriquilla' THEN
            carreras_validas := ARRAY[
                'ciencias de la tierra',
                'ciencias genomicas',
                'ingenieria aeroespacial',
                'ingenieria en energias renovables',
                'matematicas para el desarrollo',
                'negocios internacionales',
                'neurociencias',
                'ortesis y protesis',
                'tecnologia'
            ];

        -- =====================================================
        -- ESCUELA NACIONAL DE ESTUDIOS SUPERIORES UNIDAD LEON
        -- =====================================================
        WHEN 'escuela nacional de estudios superiores unidad leon' THEN
            carreras_validas := ARRAY[
                'administracion agropecuaria',
                'ciencias agrogenomicas',
                'desarrollo territorial',
                'desarrollo y gestion interculturales',
                'economia industrial',
                'fisioterapia',
                'odontologia',
                'optometria',
                'traduccion',
                'turismo y desarrollo sostenible'
            ];

        -- =====================================================
        -- ESCUELA NACIONAL DE ESTUDIOS SUPERIORES UNIDAD MERIDA
        -- =====================================================
        WHEN 'escuela nacional de estudios superiores unidad merida' THEN
            carreras_validas := ARRAY[
                'ciencias ambientales',
                'ciencias de la tierra',
                'desarrollo y gestion interculturales',
                'ecologia',
                'geografia aplicada',
                'manejo sustentable de zonas costeras',
                'sociologia aplicada'
            ];

        -- =====================================================
        -- ESCUELA NACIONAL DE ESTUDIOS SUPERIORES UNIDAD MORELIA
        -- =====================================================
        WHEN 'escuela nacional de estudios superiores unidad morelia' THEN
            carreras_validas := ARRAY[
                'administracion de archivos y gestion documental',
                'arte y diseno',
                'ciencia de materiales sustentables',
                'ciencias agroforestales',
                'ciencias ambientales',
                'ecologia',
                'estudios sociales y gestion local',
                'geociencias',
                'geohistoria',
                'historia del arte',
                'literatura intercultural',
                'musica y tecnologia artistica',
                'tecnologias para la informacion en ciencias'
            ];

        -- =====================================================
        -- ESCUELA NACIONAL DE LENGUAS LINGUISTICA Y TRADUCCION
        -- =====================================================
        WHEN 'escuela nacional de lenguas linguistica y traduccion' THEN
            carreras_validas := ARRAY[
                'linguistica aplicada',
                'traduccion'
            ];

        -- =====================================================
        -- ESCUELA NACIONAL DE TRABAJO SOCIAL
        -- =====================================================
        WHEN 'escuela nacional de trabajo social' THEN
            carreras_validas := ARRAY[
                'trabajo social'
            ];

        -- =====================================================
        -- CENTRO DE CIENCIAS GENOMICAS
        -- =====================================================
        WHEN 'centro de ciencias genomicas' THEN
            carreras_validas := ARRAY[
                'ciencias genomicas'
            ];

        -- =====================================================
        -- CENTRO DE NANOCIENCIAS Y NANOTECNOLOGIA
        -- =====================================================
        WHEN 'centro de nanociencias y nanotecnologia' THEN
            carreras_validas := ARRAY[
                'nanotecnologia'
            ];

        -- =====================================================
        -- CENTRO UNIVERSITARIO DE TEATRO
        -- =====================================================
        WHEN 'centro universitario de teatro' THEN
            carreras_validas := ARRAY[
                'teatro y actuacion'
            ];

        -- =====================================================
        -- INSTITUTO DE ENERGIAS RENOVABLES
        -- =====================================================
        WHEN 'instituto de energias renovables' THEN
            carreras_validas := ARRAY[
                'ingenieria en energias renovables'
            ];

        -- =====================================================
        -- INSTITUTO DE INVESTIGACIONES EN MATEMATICAS APLICADAS Y EN SISTEMAS
        -- =====================================================
        WHEN 'instituto de investigaciones en matematicas aplicadas y en sistemas' THEN
            carreras_validas := ARRAY[
                'ciencia de datos'
            ];

        ELSE
            RETURN NEW;
    END CASE;

    -- Validación
    IF car NOT IN (SELECT unnest(carreras_validas)) THEN
        RAISE EXCEPTION
        'La carrera "%" no pertenece a la facultad "%".',
        NEW.Carrera, NEW.Facultad;
    END IF;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_carrera_facultad
BEFORE INSERT OR UPDATE ON ParticipanteUNAM
FOR EACH ROW
EXECUTE FUNCTION validar_carrera_facultad();

/**
 * Trigger que revisa la validez de una inscripción y de ser 
 * valida,  inscribe a un participante al evento basándose en la inserción
 * realizada por un encargado en EncargadoInscribirParticipante.
 */

CREATE OR REPLACE FUNCTION trg_encargado_inscribir_part()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    edicion INTEGER;
BEGIN
    -- Validar que exista un evento en la fecha dada
    SELECT Edicion INTO edicion
    FROM Evento
    WHERE DATE_TRUNC('day', Fecha) = DATE_TRUNC('day', NEW.Fecha);

    IF edicion IS NULL THEN
        RAISE EXCEPTION
            'No existe un evento en la fecha % para determinar la edición', NEW.Fecha;
    END IF;

    -- Validar que el encargado trabaja en esa edición
    IF NOT EXISTS (
        SELECT 1
        FROM TrabajarEncargadoRegistro
        WHERE Edicion = edicion
            AND IdPersona = NEW.IdPersona_encargado
    ) THEN
        RAISE EXCEPTION
            'El encargado % no trabaja en la edición %',
            NEW.IdPersona_encargado, edicion;
    END IF;

    -- Validar que el participante no ha sido inscrito previamente
    IF EXISTS (
        SELECT 1
        FROM ParticipanteInscribirEvento
        WHERE Edicion = edicion
            AND IdPersona = NEW.IdPersona_participante
    ) THEN
        RAISE EXCEPTION
            'El participante % ya está inscrito en la edición %',
            NEW.IdPersona_participante, edicion;
    END IF;

    -- 4. Insertar en ParticipanteInscribirEvento
    INSERT INTO ParticipanteInscribirEvento(Edicion, IdPersona, Fecha, Costo)
    VALUES (edicion, NEW.IdPersona_participante, NEW.Fecha, 250.0);

    RETURN NEW;
END;
$$;

-- TRIGGER
CREATE OR REPLACE TRIGGER trg_encargado_inscribir_part
AFTER INSERT ON EncargadoInscribirParticipante
FOR EACH ROW
EXECUTE FUNCTION trg_encargado_inscribir_part();



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
    VALUES (NEW.edicion, 1500.00);

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
    edicion INTEGER,
    codigo_entrenador INTEGER
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
        WHERE D.Edicion = edicion
            AND D.CodigoDeEntrenador = codigo_entrenador
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
    p_idPersona INTEGER,
    p_codigoEntrenador INTEGER,
    p_edicion   INTEGER,
    p_idtorneo  INTEGER
)
RETURNS INTEGER
AS $$
DECLARE 
    pokemones_totales INTEGER;      
BEGIN
    SELECT COUNT(*) 
    INTO pokemones_totales
    FROM Utilizar u
    JOIN Pokemon p ON p.IdPokemon = u.IdPokemon
    WHERE p.IdPersona = p_idPersona
      AND p.CodigoDeEntrenador = p_codigoEntrenador
      AND u.Edicion = p_edicion
      AND u.IdTorneo = p_idtorneo;

    RETURN pokemones_totales;
END;
$$ LANGUAGE plpgsql;



/**
* Función para validar que un participante no registre más de 6 pokemones 
*/
CREATE OR REPLACE FUNCTION validar_limite_pokemones()
RETURNS TRIGGER AS $$
DECLARE
    v_idPersona INTEGER;
    v_codigoEntrenador INTEGER;
    total_pokemones INTEGER;
BEGIN
    SELECT p.IdPersona, p.CodigoDeEntrenador
    INTO v_idPersona, v_codigoEntrenador
    FROM Pokemon p
    WHERE p.IdPokemon = NEW.IdPokemon;

    total_pokemones := contar_pokemones_en_torneo_pelea(
                            v_idPersona,
                            v_codigoEntrenador,
                            NEW.Edicion,
                            NEW.IdTorneo
                        );

    IF total_pokemones >= 6 THEN
        RAISE EXCEPTION
            'El participante (% , %) ha alcanzado el límite de 6 pokemones en el torneo pelea % edición %.',
            v_idPersona, v_codigoEntrenador, NEW.IdTorneo, NEW.Edicion;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


/**
* Trigger para validar el límite de pokemones por participante en un torneo pelea.
*/
CREATE OR REPLACE TRIGGER trg_validar_limite_pokemones
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

    WITH peleas_cuenta AS (
        SELECT IdPersona, CodigoDeEntrenador, COUNT(*) AS cnt
        FROM PeleaTorneo
        WHERE Edicion = ed AND IdTorneo = torneo
        GROUP BY IdPersona, CodigoDeEntrenador
    )
    SELECT COUNT(*) INTO empate
    FROM peleas_cuenta
    WHERE cnt = ganador_cnt;

    -- IF empate > 1 THEN
    --     RAISE EXCEPTION 'Empate en torneo pelea %, edición %', torneo, ed;
    -- END IF;

    -- UPDATE TorneoPelea
    -- SET IdPersona = ganador_id
    -- WHERE Edicion = ed AND IdTorneo = torneo;

    IF empate = 1 THEN
        UPDATE TorneoPelea
        SET IdPersona = ganador_id
        WHERE Edicion = ed AND IdTorneo = torneo;
    END IF;
END;
$$;

/**
* Procedimiento para determinar el ganador de un torneo de distancia recorrida
* usando la cuenta con mayor distancia total. No actualiza si hay empate.
*/
CREATE OR REPLACE PROCEDURE determinar_ganador_torneo_distancia(
    edicion INT,
    torneo INT
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
                distancia_total_entrenador(edicion, CodigoDeEntrenador) AS total_dist
        FROM DistanciaRecorrida
        WHERE Edicion = edicion AND IdTorneo = torneo
        GROUP BY IdPersona, CodigoDeEntrenador
    )
    SELECT IdPersona, total_dist
    INTO ganador_id, max_distancia
    FROM distancias_cuenta
    ORDER BY total_dist DESC
    LIMIT 1;

    IF ganador_id IS NULL THEN
        RAISE EXCEPTION 'No hubo recorridos en torneo distancia recorrida %, edición %', torneo, edicion;
    END IF;

    WITH distancias_cuenta AS (
        SELECT IdPersona, CodigoDeEntrenador,
                distancia_total_entrenador(edicion, CodigoDeEntrenador) AS total_dist
        FROM DistanciaRecorrida
        WHERE Edicion = edicion AND IdTorneo = torneo
        GROUP BY IdPersona, CodigoDeEntrenador
    )
    SELECT COUNT(*) INTO empate
    FROM distancias_cuenta
    WHERE total_dist = max_distancia;

    -- IF empate > 1 THEN
    --     RAISE EXCEPTION 'Empate en torneo distancia recorrida %, edición %. Distancia recorrida: % metros',
    --         torneo, edicion, max_distancia;
    -- END IF;

    -- UPDATE TorneoDistanciaRecorrida
    -- SET IdPersona = ganador_id
    -- WHERE Edicion = edicion AND IdTorneo = torneo;

    IF empate = 1 THEN
        UPDATE TorneoDistanciaRecorrida
        SET IdPersona = ganador_id
        WHERE Edicion = edicion AND IdTorneo = torneo;
    END IF;
END;
$$;

/**
* Función para contar el número de pokémones shiny capturados por una cuenta en un torneo específico.
*/
CREATE OR REPLACE FUNCTION contar_shinys_cuenta(
    edicion INTEGER,
    torneo INTEGER,
    idpersona INTEGER,
    codigo_entrenador INTEGER
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
    WHERE r.Edicion = edicion
        AND r.IdTorneo = torneo
        AND r.IdPersona = idpersona
        AND r.CodigoDeEntrenador = codigo_entrenador
        AND p.Shiny = TRUE;

    RETURN total_shinys;
END;
$$ LANGUAGE plpgsql;

/**
* Procedimiento para determinar el ganador de un torneo de captura de shinys.
* En caso de empate, se lanza una excepción.
*/
CREATE OR REPLACE PROCEDURE determinar_ganador_torneo_shiny(
    edicion INT,
    torneo INT
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
                contar_shinys_cuenta(edicion, torneo, IdPersona, CodigoDeEntrenador) AS total_shinys
        FROM Registrar
        WHERE Edicion = edicion AND IdTorneo = torneo
        GROUP BY IdPersona, CodigoDeEntrenador
    )
    SELECT IdPersona, total_shinys
    INTO ganador_id, max_shinys
    FROM shinys_cuenta
    ORDER BY total_shinys DESC
    LIMIT 1;

    IF ganador_id IS NULL THEN
        RAISE EXCEPTION 'No hubo capturas en torneo captura shiny %, edición %', torneo, edicion;
    END IF;

    WITH shinys_cuenta AS (
        SELECT IdPersona, CodigoDeEntrenador,
                contar_shinys_cuenta(edicion, torneo, IdPersona, CodigoDeEntrenador) AS total_shinys
        FROM Registrar
        WHERE Edicion = edicion AND IdTorneo = torneo
        GROUP BY IdPersona, CodigoDeEntrenador
    )
    SELECT COUNT(*) INTO empate
    FROM shinys_cuenta
    WHERE total_shinys = max_shinys;

    -- IF empate > 1 THEN
    --     RAISE EXCEPTION 'Empate en torneo captura shiny %, edición %. Cantidad de shinys capturados: %',
    --         torneo, edicion, max_shinys;
    -- END IF;

    -- UPDATE TorneoCapturaShinys
    -- SET IdPersona = ganador_id
    -- WHERE Edicion = edicion AND IdTorneo = torneo;
    
    IF empate = 1 THEN
        UPDATE TorneoCapturaShinys
        SET IdPersona = ganador_id
        WHERE Edicion = edicion AND IdTorneo = torneo;
    END IF;
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

/**
* Función para determinar si un producto es perecedero
* (si su fecha de caducidad es NULL, no es perecedero).
*/
CREATE OR REPLACE FUNCTION es_perecedero(fecha_cad DATE)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN fecha_cad IS NULL;
END;
$$ LANGUAGE plpgsql;

/**
* Función para calcular el precio con IVA incluido (16%) de un producto.
*/
CREATE OR REPLACE FUNCTION precio_con_iva(precio REAL)
RETURNS REAL AS $$
BEGIN
    RETURN precio * 1.16;
END;
$$ LANGUAGE plpgsql;

/**
* Función para verificar que la persona que compra un alimento
* esté inscrita en la misma edición que el vendedor al que pertenece el alimento.
*/
CREATE OR REPLACE FUNCTION verificar_compra_alimento()
RETURNS TRIGGER AS $$
DECLARE
    edicion INTEGER;
BEGIN
    SELECT Edicion INTO edicion
    FROM TrabajarVendedor
    WHERE IdPersona = (SELECT IdPersona FROM Alimento WHERE IdAlimento = NEW.IdAlimento);

    IF NOT FOUND THEN
        RAISE EXCEPTION 'El alimento % no pertenece a un vendedor trabajando en alguna edición', NEW.IdAlimento;
    END IF;

    IF TG_TABLE_NAME = 'comprarcuidador' THEN
        IF NOT EXISTS (
            SELECT 1
            FROM TrabajarCuidador
            WHERE IdPersona = NEW.IdPersona
                AND Edicion = edicion
        ) THEN
            RAISE EXCEPTION 'Cuidador % no trabaja en la edición % y no puede comprar este alimento', NEW.IdPersona, edicion;
        END IF;

    ELSIF TG_TABLE_NAME = 'comprarlimpiador' THEN
        IF NOT EXISTS (
            SELECT 1
            FROM TrabajarLimpiador
            WHERE IdPersona = NEW.IdPersona
                AND Edicion = edicion
        ) THEN
            RAISE EXCEPTION 'Limpiador % no trabaja en la edición % y no puede comprar este alimento', NEW.IdPersona, edicion;
        END IF;

    ELSIF TG_TABLE_NAME = 'comprarencargadoregistro' THEN
        IF NOT EXISTS (
            SELECT 1
            FROM TrabajarEncargadoRegistro
            WHERE IdPersona = NEW.IdPersona
                AND Edicion = edicion
        ) THEN
            RAISE EXCEPTION 'Encargado % no trabaja en la edición % y no puede comprar este alimento', NEW.IdPersona, edicion;
        END IF;

    ELSIF TG_TABLE_NAME = 'comprarparticipanteunam' THEN
        IF NOT EXISTS (
            SELECT 1
            FROM ParticipanteInscribirEvento
            WHERE IdPersona = NEW.IdPersona
                AND Edicion = edicion
        ) THEN
            RAISE EXCEPTION 'Participante % no inscrito en la edición % y no puede comprar este alimento', NEW.IdPersona, edicion;
        END IF;

    ELSIF TG_TABLE_NAME = 'comprarespectador' THEN
        IF NOT EXISTS (
            SELECT 1
            FROM Asistir
            WHERE IdPersona = NEW.IdPersona
                AND Edicion = edicion
        ) THEN
            RAISE EXCEPTION 'Espectador % no inscrito en la edición % y no puede comprar este alimento', NEW.IdPersona, edicion;
        END IF;

    ELSIF TG_TABLE_NAME = 'comprarvendedor' THEN
        IF NOT EXISTS (
            SELECT 1
            FROM TrabajarVendedor
            WHERE IdPersona = NEW.IdPersona
                AND Edicion = edicion
        ) THEN
            RAISE EXCEPTION 'Vendedor % no trabaja en la edición % y no puede comprar este alimento', NEW.IdPersona, edicion;
        END IF;

    ELSE
        RAISE EXCEPTION 'Tabla de compras % no reconocida', TG_TABLE_NAME;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/**
* Trigger para verificar que el cuidador esté inscrito en la edición
* correspondiente al alimento que intenta comprar.
*/
CREATE TRIGGER trg_comprar_cuidador
BEFORE INSERT ON ComprarCuidador
FOR EACH ROW
EXECUTE FUNCTION verificar_compra_alimento();
/*** Trigger para verificar que el limpiador esté inscrito en la edición
* correspondiente al alimento que intenta comprar.
*/
CREATE TRIGGER trg_comprar_limpiador
BEFORE INSERT ON ComprarLimpiador
FOR EACH ROW
EXECUTE FUNCTION verificar_compra_alimento();
/**
* Trigger para verificar que el encargado de registro esté inscrito en la edición
* correspondiente al alimento que intenta comprar.
*/
CREATE TRIGGER trg_comprar_encargado
BEFORE INSERT ON ComprarEncargadoRegistro
FOR EACH ROW
EXECUTE FUNCTION verificar_compra_alimento();
/**
* Trigger para verificar que el participante UNAM esté inscrito en la edición
* correspondiente al alimento que intenta comprar.
*/
CREATE TRIGGER trg_comprar_participante
BEFORE INSERT ON ComprarParticipanteUNAM
FOR EACH ROW
EXECUTE FUNCTION verificar_compra_alimento();
/**
* Trigger para verificar que el espectador esté inscrito en la edición
* correspondiente al alimento que intenta comprar.
*/
CREATE TRIGGER trg_comprar_espectador
BEFORE INSERT ON ComprarEspectador
FOR EACH ROW
EXECUTE FUNCTION verificar_compra_alimento();
/**
* Trigger para verificar que el vendedor esté inscrito en la edición
* correspondiente al alimento que intenta comprar.
*/
CREATE TRIGGER trg_comprar_vendedor
BEFORE INSERT ON ComprarVendedor
FOR EACH ROW
EXECUTE FUNCTION verificar_compra_alimento();


/**
* Función para calcular el total de compras (el monto sin IVA y con IVA)
* realizadas por una persona en una edición específica, según su rol.
* Valida que la persona tenga el rol indicado en esa edición, y el alimento
* comprado pertenezca a un vendedor que trabaje en esa edición.

* Ejemplo de uso:
* SELECT 
*     MontoSinIVA AS monto_sin_iva,
*     MontoConIVA AS monto_con_iva
* FROM total_compras_persona(702,'limpiador',27);
*  monto_sin_iva | monto_con_iva 
* --------------+--------------
*        139.12 |     161.3792
* (1 row)
*/
CREATE OR REPLACE FUNCTION total_compras_persona(
    idpersona INTEGER,
    rol VARCHAR,
    edicion INTEGER
)
RETURNS TABLE (
    MontoSinIVA REAL,
    MontoConIVA REAL
) AS $$
BEGIN
    rol := LOWER(rol);
    IF rol = 'cuidador' THEN
        IF NOT EXISTS (
            SELECT 1 FROM TrabajarCuidador
            WHERE IdPersona = idpersona AND Edicion = edicion
        ) THEN
            RAISE EXCEPTION 'El cuidador % no está trabajando en la edición %',
                idpersona, edicion;
        END IF;

        SELECT COALESCE(SUM(c.cantidad * a.precio), 0)
        INTO MontoSinIVA
        FROM ComprarCuidador c
        JOIN Alimento a ON a.IdAlimento = c.IdAlimento
        JOIN TrabajarVendedor tv ON tv.IdPersona = a.IdPersona
        WHERE c.IdPersona = idpersona
            AND tv.Edicion = edicion;

        MontoConIVA := MontoSinIVA * 1.16;

        RETURN NEXT;
        RETURN;
    END IF;

    IF rol = 'limpiador' THEN
        IF NOT EXISTS (
            SELECT 1 FROM TrabajarLimpiador
            WHERE IdPersona = idpersona AND Edicion = edicion
        ) THEN
            RAISE EXCEPTION 'El limpiador % no está trabajando en la edición %',
                idpersona, edicion;
        END IF;

        SELECT COALESCE(SUM(c.cantidad * a.precio), 0)
        INTO MontoSinIVA
        FROM ComprarLimpiador c
        JOIN Alimento a ON a.IdAlimento = c.IdAlimento
        JOIN TrabajarVendedor tv ON tv.IdPersona = a.IdPersona
        WHERE c.IdPersona = idpersona
            AND tv.Edicion = edicion;

        MontoConIVA := MontoSinIVA * 1.16;
        
        RETURN NEXT;
        RETURN;
    END IF;
    
    IF rol = 'encargadoregistro' THEN
        IF NOT EXISTS (
            SELECT 1 FROM TrabajarEncargadoRegistro
            WHERE IdPersona = idpersona AND Edicion = edicion
        ) THEN
            RAISE EXCEPTION 'El encargado % no está trabajando en la edición %',
                idpersona, edicion;
        END IF;

        SELECT COALESCE(SUM(c.cantidad * a.precio), 0)
        INTO MontoSinIVA
        FROM ComprarEncargadoRegistro c
        JOIN Alimento a ON a.IdAlimento = c.IdAlimento
        JOIN TrabajarVendedor tv ON tv.IdPersona = a.IdPersona
        WHERE c.IdPersona = idpersona
            AND tv.Edicion = edicion;

        MontoConIVA := MontoSinIVA * 1.16;
        
        RETURN NEXT;
        RETURN;
    END IF;
    
    IF rol = 'participanteunam' THEN
        IF NOT EXISTS (
            SELECT 1 FROM ParticipanteInscribirEvento
            WHERE IdPersona = idpersona AND Edicion = edicion
        ) THEN
            RAISE EXCEPTION 'El participante % no está inscrito en la edición %',
                idpersona, edicion;
        END IF;

        SELECT COALESCE(SUM(c.cantidad * a.precio), 0)
        INTO MontoSinIVA
        FROM ComprarParticipanteUNAM c
        JOIN Alimento a ON a.IdAlimento = c.IdAlimento
        JOIN TrabajarVendedor tv ON tv.IdPersona = a.IdPersona
        WHERE c.IdPersona = idpersona
            AND tv.Edicion = edicion;

        MontoConIVA := MontoSinIVA * 1.16;
        
        RETURN NEXT;
        RETURN;
    END IF;
    
    IF rol = 'espectador' THEN
        IF NOT EXISTS (
            SELECT 1 FROM Asistir
            WHERE IdPersona = idpersona AND Edicion = edicion
        ) THEN
            RAISE EXCEPTION 'El espectador % no está inscrito en la edición %',
                idpersona, edicion;
        END IF;

        SELECT COALESCE(SUM(c.cantidad * a.precio), 0)
        INTO MontoSinIVA
        FROM ComprarEspectador c
        JOIN Alimento a ON a.IdAlimento = c.IdAlimento
        JOIN TrabajarVendedor tv ON tv.IdPersona = a.IdPersona
        WHERE c.IdPersona = idpersona
            AND tv.Edicion = edicion;

        MontoConIVA := MontoSinIVA * 1.16;
        
        RETURN NEXT;
        RETURN;
    END IF;
    
    IF rol = 'vendedor' THEN
        IF NOT EXISTS (
            SELECT 1 FROM TrabajarVendedor
            WHERE IdPersona = idpersona AND Edicion = edicion
        ) THEN
            RAISE EXCEPTION 'El vendedor % no está trabajando en la edición %',
                idpersona, edicion;
        END IF;

        SELECT COALESCE(SUM(c.cantidad * a.precio), 0)
        INTO MontoSinIVA
        FROM ComprarVendedor c
        JOIN Alimento a ON a.IdAlimento = c.IdAlimento
        JOIN TrabajarVendedor tv ON tv.IdPersona = a.IdPersona
        WHERE c.IdPersona = idpersona
            AND tv.Edicion = edicion;

        MontoConIVA := MontoSinIVA * 1.16;
        
        RETURN NEXT;
        RETURN;
    END IF;
    
    RAISE EXCEPTION 'Rol "%" no válido', rol;
END;
$$ LANGUAGE plpgsql;

/**
* Procedimiento para calcular la ganancia total de ventas de un vendedor
* en una edición específica.
*/
CREATE OR REPLACE FUNCTION calcular_ventas_vendedor(
    idvendedor INTEGER,
    edicion INTEGER
)
RETURNS REAL
LANGUAGE plpgsql
AS $$
DECLARE
    total_ventas REAL;
BEGIN
    SELECT COALESCE(SUM(c.Cantidad * a.Precio), 0)
    INTO total_ventas
    FROM (
        SELECT IdAlimento, Cantidad FROM ComprarCuidador
        UNION ALL
        SELECT IdAlimento, Cantidad FROM ComprarLimpiador
        UNION ALL
        SELECT IdAlimento, Cantidad FROM ComprarEncargadoRegistro
        UNION ALL
        SELECT IdAlimento, Cantidad FROM ComprarParticipanteUNAM
        UNION ALL
        SELECT IdAlimento, Cantidad FROM ComprarEspectador
        UNION ALL
        SELECT IdAlimento, Cantidad FROM ComprarVendedor
    ) c
    JOIN Alimento a ON a.IdAlimento = c.IdAlimento
    JOIN TrabajarVendedor tv ON tv.IdPersona = a.IdPersona
    WHERE tv.Edicion = edicion
        AND a.IdPersona = idvendedor;

    RETURN total_ventas;
END;
$$;

/**
* Función para calcular el salario de un vendedor en una edición específica,
* considerando el 25% de sus ventas totales.
*/
CREATE OR REPLACE FUNCTION salario_vendedor(
    idvendedor INTEGER,
    edicion INTEGER
)
RETURNS REAL AS $$
DECLARE
    total_ventas REAL;
BEGIN
    total_ventas := calcular_ventas_vendedor(idvendedor, edicion);
    RETURN total_ventas * 0.25;
END;
$$ LANGUAGE plpgsql;

/**
* Función para contar el número de participantes inscritos por un Encargado de Registro
* en una edición específica.
*/
CREATE OR REPLACE FUNCTION contar_inscritos_encargado(
    idpersona INTEGER,
    edicion INTEGER
)
RETURNS INTEGER AS $$
DECLARE
    inscritos INTEGER;
BEGIN
    SELECT COUNT(*) INTO inscritos
    FROM EncargadoInscribirParticipante eip
    JOIN ParticipanteInscribirEvento pie
        ON eip.IdPersona_participante = pie.IdPersona
        AND pie.Edicion = edicion
    WHERE eip.IdPersona_encargado = idpersona;

    RETURN inscritos;
END;
$$ LANGUAGE plpgsql;

/**
* Función para calcular el salario de un Encargado de Registro
* en una edición específica, considerando 50 pesos por cada participante inscrito.
*/
CREATE OR REPLACE FUNCTION salario_encargado_registro(
    idpersona INTEGER,
    edicion INTEGER
)
RETURNS REAL AS $$
DECLARE
    inscritos INTEGER;
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM EncargadoRegistro WHERE IdPersona = idpersona
    ) THEN
        RAISE EXCEPTION 'Encargado con id % no existe', idpersona;
    END IF;
    inscritos := contar_inscritos_encargado(idpersona, edicion);
    RETURN inscritos * 50.0;
END;
$$ LANGUAGE plpgsql;

/**
* Función para validar que un participante esté inscrito en el evento general
* antes de inscribirse en un torneo específico.
*/
CREATE OR REPLACE FUNCTION validar_inscripcion_torneo()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM ParticipanteInscribirEvento
        WHERE Edicion = NEW.Edicion AND IdPersona = NEW.IdPersona
    ) THEN
        RAISE EXCEPTION 'El participante % no está inscrito en el evento general de la edición %', NEW.IdPersona, NEW.Edicion;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
/**
* Trigger para validar inscripción en torneo pelea.
*/
CREATE TRIGGER trg_validar_inscripcion_torneo
BEFORE INSERT ON InscripcionTorneoPelea
FOR EACH ROW
EXECUTE FUNCTION validar_inscripcion_torneo();
/**
* Trigger para validar inscripción en torneo distancia recorrida.
*/
CREATE TRIGGER trg_validar_inscripcion_torneo_distancia
BEFORE INSERT ON InscripcionTorneoDistancia
FOR EACH ROW
EXECUTE FUNCTION validar_inscripcion_torneo();
/**
* Trigger para validar inscripción en torneo captura de shinys.
*/
CREATE TRIGGER trg_validar_inscripcion_torneo_captura
BEFORE INSERT ON InscripcionTorneoCaptura
FOR EACH ROW
EXECUTE FUNCTION validar_inscripcion_torneo();

/**
* Función para verificar que un participante esté inscrito en el torneo de pelea
* antes de registrar una pelea en el torneo.
*/
CREATE OR REPLACE FUNCTION verificar_inscripcion_pelea()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM InscripcionTorneoPelea i
        WHERE i.Edicion = NEW.Edicion
            AND i.IdTorneo = NEW.IdTorneo
            AND i.IdPersona = NEW.IdPersona
            AND i.CodigoDeEntrenador = NEW.CodigoDeEntrenador
    ) THEN
        RAISE EXCEPTION 'El participante % con código de entrenador % no está inscrito en el torneo pelea % edición %',
            NEW.IdPersona, NEW.CodigoDeEntrenador, NEW.IdTorneo, NEW.Edicion;
    END IF;

    RETURN NEW;
END;
$$;
/**
* Trigger para verificar inscripción en torneo pelea.
*/
CREATE TRIGGER trg_verificar_inscripcion_pelea
BEFORE INSERT ON PeleaTorneo
FOR EACH ROW
EXECUTE FUNCTION verificar_inscripcion_pelea();

/**
* Función para verificar que un participante esté inscrito en el torneo de distancia
* antes de registrar una distancia recorrida en el torneo.
*/
CREATE OR REPLACE FUNCTION verificar_inscripcion_distancia()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM InscripcionTorneoDistancia i
        WHERE i.Edicion = NEW.Edicion
            AND i.IdTorneo = NEW.IdTorneo
            AND i.IdPersona = NEW.IdPersona
            AND i.CodigoDeEntrenador = NEW.CodigoDeEntrenador
    ) THEN
        RAISE EXCEPTION 'El participante % con código de entrenador % no está inscrito en el torneo de distancia % edición %',
            NEW.IdPersona, NEW.CodigoDeEntrenador, NEW.IdTorneo, NEW.Edicion;
    END IF;

    RETURN NEW;
END;
$$;
/**
* Trigger para verificar inscripción en torneo distancia recorrida.
*/
CREATE TRIGGER trg_verificar_inscripcion_distancia
BEFORE INSERT ON DistanciaRecorrida
FOR EACH ROW
EXECUTE FUNCTION verificar_inscripcion_distancia();

/**
* Función para verificar que un participante esté inscrito en el torneo de capturas
* antes de registrar una captura en el torneo.
*/
CREATE OR REPLACE FUNCTION verificar_inscripcion_captura()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM InscripcionTorneoCaptura i
        WHERE i.Edicion = NEW.Edicion
            AND i.IdTorneo = NEW.IdTorneo
            AND i.IdPersona = NEW.IdPersona
            AND i.CodigoDeEntrenador = NEW.CodigoDeEntrenador
    ) THEN
        RAISE EXCEPTION 'El participante % con código de entrenador % no está inscrito en el torneo de capturas % edición %',
            NEW.IdPersona, NEW.CodigoDeEntrenador, NEW.IdTorneo, NEW.Edicion;
    END IF;

    RETURN NEW;
END;
$$;
/**
* Trigger para verificar inscripción en torneo captura de shinys.
*/
CREATE TRIGGER trg_verificar_inscripcion_captura
BEFORE INSERT ON Registrar
FOR EACH ROW
EXECUTE FUNCTION verificar_inscripcion_captura();

/**
* Función para calcular la ganancia total de un evento en una edición específica.
* Ganancia = ventas totales + ingresos por inscripciones - salarios - premios
*/
CREATE OR REPLACE FUNCTION ganancia_evento(edicion INTEGER)
RETURNS REAL AS $$
DECLARE
    total_ventas REAL := 0;
    ingresos_inscripcion REAL := 0;
    salarios_encargados REAL := 0;
    salarios_vendedores REAL := 0;
    salarios_cuidador REAL := 0;
    salarios_limpiador REAL := 0;
    premios_totales REAL := 0;
BEGIN
    -- 1. Total de ventas 
    SELECT COALESCE(SUM(c.Cantidad * a.Precio),0)
    INTO total_ventas
    FROM (
        SELECT * FROM ComprarCuidador
        UNION ALL
        SELECT * FROM ComprarLimpiador
        UNION ALL
        SELECT * FROM ComprarEncargadoRegistro
        UNION ALL
        SELECT * FROM ComprarParticipanteUNAM
        UNION ALL
        SELECT * FROM ComprarEspectador
        UNION ALL
        SELECT * FROM ComprarVendedor
    ) c
    JOIN Alimento a ON a.IdAlimento = c.IdAlimento
    JOIN TrabajarVendedor tv ON tv.IdPersona = a.IdPersona
    WHERE tv.Edicion = edicion;

    -- 2. Ingresos por inscripciones
    SELECT COALESCE(SUM(Costo),0)
    INTO ingresos_inscripcion
    FROM ParticipanteInscribirEvento
    WHERE Edicion = edicion;

    -- 3. Salarios de vendedores
    SELECT COALESCE(SUM(salario_vendedor(v.IdPersona, edicion)),0)
    INTO salarios_vendedores
    FROM Vendedor v
    JOIN TrabajarVendedor tv ON tv.IdPersona = v.IdPersona
    WHERE tv.Edicion = edicion;

    -- 4. Salarios de encargados
    SELECT COALESCE(SUM(salario_encargado_registro(er.IdPersona, edicion)),0)
    INTO salarios_encargados
    FROM EncargadoRegistro er
    JOIN TrabajarEncargadoRegistro ter ON ter.IdPersona = er.IdPersona
    WHERE ter.Edicion = edicion;

    -- 5. Salarios de cuidadores 
    SELECT COALESCE(SUM(cu.Salario),0)
    INTO salarios_cuidador
    FROM Cuidador cu
    JOIN TrabajarCuidador tc ON tc.IdPersona = cu.IdPersona
    WHERE tc.Edicion = edicion;

    -- 6. Salarios de limpiadores 
    SELECT COALESCE(SUM(li.Salario),0)
    INTO salarios_limpiador
    FROM Limpiador li
    JOIN TrabajarLimpiador tl ON tl.IdPersona = li.IdPersona
    WHERE tl.Edicion = edicion;

    -- 7. Premios totales de torneos
    SELECT COALESCE(SUM(CantidadAPremiar),0)
    INTO premios_totales
    FROM (
        SELECT CantidadAPremiar FROM TorneoPelea WHERE Edicion = edicion
        UNION ALL
        SELECT CantidadAPremiar FROM TorneoDistanciaRecorrida WHERE Edicion = edicion
        UNION ALL
        SELECT CantidadAPremiar FROM TorneoCapturaShinys WHERE Edicion = edicion
    ) t;

    -- Ganancia 
    RETURN total_ventas + ingresos_inscripcion
            - (salarios_vendedores + salarios_encargados + salarios_cuidador + salarios_limpiador + premios_totales);
END;
$$ LANGUAGE plpgsql;

/**
* Función para validar que un trabajador tenga al menos 18 años
* en la fecha del evento correspondiente a la edición en la que trabaja.
*/
CREATE OR REPLACE FUNCTION validar_trabajador()
RETURNS TRIGGER AS $$
DECLARE
    fecha_nacimiento date;
    fecha_evento date;
    tabla text := LOWER(TG_TABLE_NAME);
BEGIN
    SELECT Fecha
    INTO fecha_evento
    FROM Evento
    WHERE Edicion = NEW.Edicion;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'La edición % no existe.', NEW.Edicion;
    END IF;

    IF tabla = 'trabajarcuidador' THEN
        SELECT FechaNacimiento INTO fecha_nacimiento
        FROM Cuidador
        WHERE IdPersona = NEW.IdPersona;

    ELSIF tabla = 'trabajarlimpiador' THEN
        SELECT FechaNacimiento INTO fecha_nacimiento
        FROM Limpiador
        WHERE IdPersona = NEW.IdPersona;

    ELSIF tabla = 'trabajarvendedor' THEN
        SELECT FechaNacimiento INTO fecha_nacimiento
        FROM Vendedor
        WHERE IdPersona = NEW.IdPersona;

    ELSIF tabla = 'trabajarencargadoregistro' THEN
        SELECT FechaNacimiento INTO fecha_nacimiento
        FROM EncargadoRegistro
        WHERE IdPersona = NEW.IdPersona;

    ELSE
        RAISE EXCEPTION 'Tabla % no reconocida.', tabla;
    END IF;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'El trabajador % no existe.', NEW.IdPersona;
    END IF;

    IF age(fecha_evento, fecha_nacimiento) < interval '18 years' THEN
        RAISE EXCEPTION
            'La persona % es menor de edad para trabajar en la edición %.',
            NEW.IdPersona, NEW.Edicion;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/**
* Valida la edad mínima de un vendedor.
*/
CREATE TRIGGER trg_validar_vendedor
BEFORE INSERT OR UPDATE ON TrabajarVendedor
FOR EACH ROW
EXECUTE FUNCTION validar_trabajador();
/**
* Valida la edad mínima de un cuidador.
*/
CREATE TRIGGER trg_validar_cuidador
BEFORE INSERT OR UPDATE ON TrabajarCuidador
FOR EACH ROW
EXECUTE FUNCTION validar_trabajador();
/** 
* Valida la edad mínima de un limpiador.
*/
CREATE TRIGGER trg_validar_limpiador
BEFORE INSERT OR UPDATE ON TrabajarLimpiador
FOR EACH ROW
EXECUTE FUNCTION validar_trabajador();
/**
* Valida la edad mínima de un encargado de registro.
*/
CREATE TRIGGER trg_validar_encargado_registro
BEFORE INSERT OR UPDATE ON TrabajarEncargadoRegistro
FOR EACH ROW
EXECUTE FUNCTION validar_trabajador();


