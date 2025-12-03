-- 1(practica). Calcular la distancia total recorrida en kilómetros por los participantes de cada facultad, desglosada por sexo / género.
WITH distancia_total AS (
    SELECT
        dr.IdPersona,
        dr.Edicion,
        dr.CodigoDeEntrenador,
        distancia_total_entrenador(dr.Edicion, dr.CodigoDeEntrenador) AS distancia_total
    FROM DistanciaRecorrida dr
    GROUP BY
        dr.IdPersona,
        dr.Edicion,
        dr.CodigoDeEntrenador
)
SELECT
    p.Facultad,
    p.Sexo,
    SUM(dt.distancia_total) / 1000 AS kilometros_recorridos
FROM distancia_total dt
JOIN ParticipanteUNAM p
    ON p.IdPersona = dt.IdPersona
GROUP BY
    p.Facultad,
    p.Sexo
ORDER BY
    p.Facultad,
    p.Sexo;


-- 2. Top 5 pokemones mas registrados en el torneo de peleas 
WITH Conteo AS (
    SELECT
        tp.Edicion,
        u.IdPokemon,
        p.Nombre AS NombrePokemon,
        COUNT(*) AS VecesRegistrado
    FROM TorneoPelea tp
    JOIN Utilizar u 
        ON u.Edicion = tp.Edicion AND u.IdTorneo = tp.IdTorneo
    JOIN Pokemon p 
        ON p.IdPokemon = u.IdPokemon
    GROUP BY tp.Edicion, u.IdPokemon, p.Nombre
),
Top5 AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY Edicion
            ORDER BY VecesRegistrado DESC
        ) AS rn
    FROM Conteo
)
SELECT
    Edicion,
    IdPokemon,
    NombrePokemon,
    VecesRegistrado
FROM Top5
WHERE rn <= 5
ORDER BY Edicion, VecesRegistrado DESC;


-- 3. Recuperar las 10 horas del día con más capturas de Pokémon shinys durante los torneos.
SELECT
    EXTRACT(HOUR FROM r.Hora) AS hora,
    COUNT(*) AS total_capturas_shiny
FROM Registrar r
JOIN Pokemon p 
    ON p.IdPokemon = r.IdPokemon
WHERE p.Shiny = TRUE
GROUP BY EXTRACT(HOUR FROM r.Hora)
ORDER BY total_capturas_shiny DESC
LIMIT 10;

-- 4. Reportar las ganancias totales obtenidas en cada evento, ordenadas de mayor a menor ganancia.
SELECT
    e.Edicion,
    COALESCE(ganancia_evento(e.Edicion), 0) AS Ganancia
FROM Evento e
ORDER BY Ganancia DESC;

-- 5.(practica) Obtener la lista de participantes que estén inscritos en el Torneo de Captura de Shiny y a su vez que no estén inscritos en el torneo de distancia recorrida.
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


-- 6.(practica) Listar los Pokémones shinys, que fueron capturados durante el evento, únicamente si fueron capturados entre
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

-- 7.(practica) Obtener el nombre completo de los participantes y su facultad que hayan participado tanto en el torneo de distancia recorrida como en el de captura de shinys, cuya distancia total recorrida sea mayor al promedio de distancia de todos los participantes y ademas que su numero de capturas de shinys sean mayor a 5.
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


-- 8.(practica) Calcular la distancia total recorrida por cada participante en el torneo de distancia recorrida en kilómetros, 
-- utilizando las coordenadas geográficas de cada locación.

WITH Reg AS (
    SELECT
        d.idpersona,
        d.edicion,
        d.idtorneo,
        d.nombrelocacion AS actual,
        d.fecha,
        d.hora,
        LEAD(d.nombrelocacion) OVER (
            PARTITION BY d.edicion, d.idtorneo, d.idpersona
            ORDER BY d.fecha, d.hora
        ) AS siguiente
    FROM distanciarecorrida d
),
Coords AS (
    SELECT
        r.idpersona,
        r.edicion,
        r.idtorneo,
        c1.lat  AS lat1, c1.lon AS lon1,
        c2.lat AS lat2, c2.lon AS lon2
    FROM Reg r
    JOIN Locacion c1 ON c1.locacion = r.cp_actual
    JOIN Locacion c2 ON c2.locacion = r.cp_siguiente
    WHERE r.cp_siguiente IS NOT NULL
)
SELECT
    edicion,
    idtorneo,
    idpersona,
    SUM(
        6371 * acos(
            cos(radians(lat1)) * cos(radians(lat2)) *
            cos(radians(lon2) - radians(lon1)) +
            sin(radians(lat1)) * sin(radians(lat2))
        )
    ) AS distancia_total_km
FROM Coords
GROUP BY edicion, idtorneo, idpersona
ORDER BY distancia_total_km DESC;

-- 9. Sacar porcentaje de ganadores mujeres vs hombres en los tres torneos.
WITH TodosGanadores AS (
    SELECT IdPersona FROM TorneoPelea
    UNION ALL
    SELECT IdPersona FROM TorneoDistanciaRecorrida
    UNION ALL
    SELECT IdPersona FROM TorneoCapturaShinys
),
ConteoPorSexo AS (
    SELECT p.Sexo, COUNT(*) AS total
    FROM TodosGanadores g
    JOIN ParticipanteUNAM p ON p.IdPersona = g.IdPersona
    GROUP BY p.Sexo
),
Total AS (
    SELECT SUM(total) AS total_global FROM ConteoPorSexo
)
SELECT 
    c.Sexo,
    ROUND((c.total::DECIMAL / t.total_global) * 100, 2) AS porcentaje
FROM ConteoPorSexo c, Total t
ORDER BY porcentaje DESC;

-- 10. Vendedores ordenados por ganancia y su producto más vendido.

WITH TodasLasCompras AS (

    SELECT a.IdPersona AS IdVendedor, c.IdAlimento, c.Cantidad, a.Precio
    FROM ComprarEncargadoRegistro c
    JOIN Alimento a ON c.IdAlimento = a.IdAlimento

    UNION ALL
 
    SELECT a.IdPersona AS IdVendedor, c.IdAlimento, c.Cantidad, a.Precio
    FROM ComprarLimpiador c
    JOIN Alimento a ON c.IdAlimento = a.IdAlimento

    UNION ALL
  
    SELECT a.IdPersona AS IdVendedor, c.IdAlimento, c.Cantidad, a.Precio
    FROM ComprarCuidador c
    JOIN Alimento a ON c.IdAlimento = a.IdAlimento

    UNION ALL
   
    SELECT a.IdPersona AS IdVendedor, c.IdAlimento, c.Cantidad, a.Precio
    FROM ComprarVendedor c
    JOIN Alimento a ON c.IdAlimento = a.IdAlimento

    UNION ALL
  
    SELECT a.IdPersona AS IdVendedor, c.IdAlimento, c.Cantidad, a.Precio
    FROM ComprarEspectador c
    JOIN Alimento a ON c.IdAlimento = a.IdAlimento

    UNION ALL

    SELECT a.IdPersona AS IdVendedor, c.IdAlimento, c.Cantidad, a.Precio
    FROM ComprarParticipanteUNAM c
    JOIN Alimento a ON c.IdAlimento = a.IdAlimento
),

GananciasPorVendedor AS (
    SELECT IdVendedor, SUM(Cantidad * Precio) AS GananciaTotal
    FROM TodasLasCompras
    GROUP BY IdVendedor
),

ProductoMasVendido AS (
    SELECT t.IdVendedor, t.IdAlimento,
           SUM(t.Cantidad) AS TotalVendidos,
           ROW_NUMBER() OVER (PARTITION BY t.IdVendedor ORDER BY SUM(t.Cantidad) DESC) AS rn
    FROM TodasLasCompras t
    GROUP BY t.IdVendedor, t.IdAlimento
)

SELECT 
    v.IdPersona AS IdVendedor,
    v.Nombre,
    v.ApellidoPaterno,
    v.ApellidoMaterno,
    g.GananciaTotal,
    a.Nombre AS ProductoMasVendido,
    pmv.TotalVendidos
FROM Vendedor v
LEFT JOIN GananciasPorVendedor g ON v.IdPersona = g.IdVendedor
LEFT JOIN ProductoMasVendido pmv ON v.IdPersona = pmv.IdVendedor AND pmv.rn = 1
LEFT JOIN Alimento a ON pmv.IdAlimento = a.IdAlimento
ORDER BY g.GananciaTotal DESC NULLS LAST;

-- 11. Sacar los pokemones mas usados por los ganadores de las peleas.

-- 12. Porcentaje de pokemones por tipo capturados en el torneo de captura.

-- 13. El jugador que más peleas perdió en el torneo de peleas.

-- 14. Porcentaje de participantes por facultad en el torneo de distancia recorrida.

-- 15. Porcentaje de pokemones shinys capturados por sexo/género de los participantes en el torneo de captura de shinys.

-- 16. Listar los pokemones que han sido usados en más de un torneo, indicando en cuántos torneos han sido usados.

-- 17. Listar los participantes que han ganado en más de un torneo, indicando en cuántos torneos han ganado.

