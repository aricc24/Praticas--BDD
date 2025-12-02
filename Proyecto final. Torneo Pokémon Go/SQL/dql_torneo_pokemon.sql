-- i. Mostrar el nombre completo de todos los participantes junto con su cuenta de Pokémon Go.
SELECT 
    p.Nombre || ' ' || p.ApellidoPaterno || ' ' || p.ApellidoMaterno AS NombreCompleto,
    c.NombreDeUsuario AS CuentaPokemonGo
FROM ParticipanteUNAM p
JOIN CuentaPokemonGo c
    ON p.IdPersona = c.IdPersona;

-- ii. Calcular cuántos Pokémons registró cada participante para el torneo de peleas por cada una de las ediciones.
SELECT
    r.Edicion,
    r.IdPersona,
    COUNT(r.IdPokemon) AS TotalPokemonRegistrados
FROM Registrar r
GROUP BY
    r.Edicion,
    r.IdPersona
ORDER BY
    r.Edicion,
    r.IdPersona;

-- iii. Listar todos los Pokémones cuya especie contenga la cadena ćhu ́
SELECT * FROM Pokemon WHERE Especie ILIKE '%chu%';

-- iv. Obtener la lista de participantes que estén inscritos en el Torneo de Captura de Shiny y a su vez que no estén inscritos en el torneo de distancia recorrida.
WITH participantes_shiny AS (
    SELECT DISTINCT IdPersona
    FROM Registrar
),
participantes_distancia AS (
    SELECT DISTINCT IdPersona
    FROM DistanciaRecorrida
)
SELECT 
    p.IdPersona,
    p.Nombre || ' ' || p.ApellidoPaterno || ' ' || p.ApellidoMaterno AS NombreCompleto
FROM ParticipanteUNAM p
JOIN participantes_shiny s
    ON p.IdPersona = s.IdPersona
LEFT JOIN participantes_distancia d
    ON p.IdPersona = d.IdPersona
WHERE d.IdPersona IS NULL;

-- v. Calcular la distancia total recorrida por cada participante en el torneo de distancia recorrida.
WITH Recorridos AS (
    SELECT 
        dr.IdPersona,
        SUM(
            CASE LOWER(dr.Locacion)
                WHEN 'entrada' THEN 0
                WHEN 'universum' THEN 100
                WHEN 'rectoria' THEN 200
                ELSE 0
            END
        ) AS DistanciaTotal
    FROM DistanciaRecorrida dr
    GROUP BY dr.IdPersona
)
SELECT 
    p.IdPersona,
    p.Nombre || ' ' || p.ApellidoPaterno || ' ' || p.ApellidoMaterno AS NombreCompleto,
    r.DistanciaTotal
FROM Recorridos r
JOIN ParticipanteUNAM p
    ON r.IdPersona = p.IdPersona
    WHERE r.DistanciaTotal IS NOT NULL
    GROUP BY r.DistanciaTotal, p.idpersona, NombreCompleto
    ORDER BY r.DistanciaTotal DESC;

-- vi. Listar los Pokémones shinys, que fueron capturados durante el evento, únicamente si fueron capturados entre
-- las 14:00hrs y las 18:00hrs.
SELECT
    p.idpokemon,
    r.hora,
    p.nombre,
    p.especie,
    p.tipo,
    p.shiny,
    r.fecha,
    r.idpersona,
    r.edicion,
    r.idtorneo
FROM
    registrar r JOIN pokemon p ON p.idpokemon = r.idpokemon 
    JOIN capturapokemon c ON c.edicion = r.edicion
    AND r.idtorneo = c.idtorneo
    AND r.idcaptura = c.idcaptura
WHERE
    p.shiny = TRUE
    AND r.hora BETWEEN '14:00:00' AND '18:00:00';

-- vii. Mostrar a todos los vendedores junto con los alimentos que venden, indicando el precio sin IVA y el precio final
-- con IVA del 16 %.
SELECT 
    v.Nombre || ' ' || v.ApellidoPaterno || ' ' || v.ApellidoMaterno 
        AS NombreCompleto,
        a.nombre AS nombre_alimento,
        precio, 
        precio * 1.16 AS precio_iva
FROM alimento a
RIGHT JOIN vendedor v ON a.idpersona = v.idpersona;

-- viii. Mostrar las facultades que tienen más de 5 participantes inscritos en cualquier torneo.
SELECT pu.Facultad,
       COUNT(participantesTorneos.IdPersona) AS TotalParticipantes
FROM (
    SELECT IdPersona FROM InscripcionTorneoPelea
    UNION
    SELECT IdPersona FROM InscripcionTorneoDistancia
    UNION
    SELECT IdPersona FROM InscripcionTorneoCaptura
) participantesTorneos
JOIN ParticipanteUNAM pu ON pu.IdPersona = participantesTorneos.IdPersona
GROUP BY pu.Facultad
HAVING COUNT(participantesTorneos.IdPersona) > 5;

-- ix. Listar a los vendedores cuyo total de alimentos de alimentos vendidos (número de productos distintos que ofrecen) sea mayor a 3.
SELECT v.* FROM Vendedor v JOIN Alimento a ON v.IdPersona = a.IdPersona GROUP BY v.IdPersona HAVING COUNT(DISTINCT a.IdAlimento) > 3;

-- x. Obtener el nombre completo de los participantes y su facultad que hayan participado tanto en el torneo de distancia recorrida como en el de captura de shinys, cuya distancia total recorrida sea mayor al promedio de distancia de todos los participantes y ademas que su numero de capturas de shinys sean mayor a 5.
SELECT 
    pu.Nombre || ' ' || pu.ApellidoPaterno || ' ' || pu.ApellidoMaterno AS NombreCompleto,
    pu.Facultad
FROM (  SELECT 
            dr.IdPersona,
            SUM(CASE lower(dr.Locacion)
                    WHEN 'entrada'   THEN 0
                    WHEN 'universum' THEN 100
                    WHEN 'rectoria'  THEN 200
                END) AS DistanciaTotal
        FROM DistanciaRecorrida dr
        GROUP BY dr.IdPersona
    ) AS dt
JOIN (  SELECT 
            r.IdPersona, 
            COUNT(DISTINCT r.IdCaptura) AS NumeroCapturas
        FROM Registrar r
        JOIN Pokemon p ON p.IdPokemon = r.IdPokemon
        WHERE p.Shiny = TRUE
        GROUP BY r.IdPersona
    ) AS cs 
        ON cs.IdPersona = dt.IdPersona
JOIN ParticipanteUNAM pu
        ON pu.IdPersona = dt.IdPersona
WHERE 
    cs.NumeroCapturas > 5 
    AND dt.DistanciaTotal >
        (   SELECT 
                AVG(suma.DistanciaTotal)
            FROM ( SELECT 
                    dr2.IdPersona,
                    SUM(CASE lower(dr2.Locacion)
                            WHEN 'entrada'   THEN 0
                            WHEN 'universum' THEN 100
                            WHEN 'rectoria'  THEN 200
                        END) AS DistanciaTotal
                FROM DistanciaRecorrida dr2
                GROUP BY dr2.IdPersona
            ) AS suma
        );







-------

CREATE OR REPLACE PROCEDURE generar_1000_inscripciones_valido()
LANGUAGE plpgsql
AS $$
DECLARE
    contador INTEGER := 0;
    p_edicion INTEGER;
    p_idparticipante INTEGER;
    p_idencargado INTEGER;
    p_fecha TIMESTAMPTZ;

    encargados_por_edicion JSONB;
    ediciones_con_encargados INTEGER[];
    max_participante_id INTEGER;

BEGIN
    RAISE NOTICE '=== INICIANDO GENERACIÓN VÁLIDA DE 1000 INSCRIPCIONES ===';

    -- Obtener máximo participante actual
    SELECT COALESCE(MAX(IdPersona), 1000)
    INTO max_participante_id
    FROM ParticipanteUNAM;

    -- Crear mapa JSON: edicion -> encargados
    SELECT jsonb_object_agg(edicion::text, encargados)
    INTO encargados_por_edicion
    FROM (
        SELECT Edicion AS edicion, array_agg(IdPersona) AS encargados
        FROM TrabajarEncargadoRegistro
        GROUP BY Edicion
        HAVING COUNT(*) > 0
    ) sub;

    -- Lista de ediciones válidas
    SELECT array_agg(DISTINCT Edicion)
    INTO ediciones_con_encargados
    FROM TrabajarEncargadoRegistro;

    IF ediciones_con_encargados IS NULL THEN
        RAISE EXCEPTION 'No hay ediciones válidas.';
    END IF;

    WHILE contador < 1000 LOOP

        -- Edición válida
        p_edicion :=
            ediciones_con_encargados[
                floor(random() * array_length(ediciones_con_encargados, 1))::int + 1
            ];

        -- ID participante nuevo
        max_participante_id := max_participante_id + 1;
        p_idparticipante := max_participante_id;

        -- Insertar participante (sin tabla Persona)
        INSERT INTO ParticipanteUNAM(IdPersona)
        VALUES(p_idparticipante)
        ON CONFLICT DO NOTHING;

        -- Encargado aleatorio
        SELECT (encargados_por_edicion->p_edicion::text)->>idx
        INTO p_idencargado
        FROM LATERAL (
            SELECT floor(random() * jsonb_array_length(encargados_por_edicion->p_edicion::text))::int AS idx
        ) s;

        -- Fecha aleatoria 2024
        p_fecha := '2024-01-01'::timestamp
                   + (floor(random() * 365) || ' days')::interval
                   + (floor(random() * 86400) || ' seconds')::interval;

        BEGIN
            CALL inscribir_participante_evento(
                p_edicion,
                p_idparticipante,
                p_idencargado,
                p_fecha
            );

            contador := contador + 1;

            IF contador % 100 = 0 THEN
                RAISE NOTICE '% inscripciones creadas', contador;
            END IF;

        EXCEPTION WHEN OTHERS THEN
            RAISE NOTICE 'Error con participante %: %', p_idparticipante, SQLERRM;
            max_participante_id := max_participante_id - 1;
            CONTINUE;
        END;

    END LOOP;

    RAISE NOTICE '=== FINALIZADO: % inscripciones creadas ===', contador;

END;
$$;







---- Para el proyecto

-- 1. Distancia recorrida hombres vs mujeres de cada facultad 

-- 2. Top 5 pokemones mas registrados en el torneo de peleas 

-- 3. Top 10 horas con mas capturas de shiny

