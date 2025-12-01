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

CREATE TRIGGER trigger_crear_torneos
AFTER INSERT ON Evento
FOR EACH ROW
EXECUTE FUNCTION crear_torneos_al_insertar_evento();


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

CREATE TRIGGER trg_validar_jugador
BEFORE INSERT OR UPDATE ON Encargado
FOR EACH ROW
EXECUTE FUNCTION validar_encargado_jugador();



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