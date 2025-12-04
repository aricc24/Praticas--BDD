-- Determina ganadores
DO $$
DECLARE
    t RECORD;
BEGIN
    FOR t IN SELECT Edicion, IdTorneo FROM TorneoPelea LOOP
        CALL determinar_ganador_torneo_pelea(t.Edicion, t.IdTorneo);
    END LOOP;

    FOR t IN SELECT Edicion, IdTorneo FROM TorneoDistanciaRecorrida LOOP
        CALL determinar_ganador_torneo_distancia(t.Edicion, t.IdTorneo);
    END LOOP;
    FOR t IN SELECT Edicion, IdTorneo FROM TorneoCapturaShinys LOOP
        CALL determinar_ganador_torneo_shiny(t.Edicion, t.IdTorneo);
    END LOOP;
END $$;

-- 1. (practica). Calcular la distancia total recorrida en kilómetros por los participantes de cada facultad, desglosada por sexo / género.
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
    pu.Facultad,
    pu.Sexo,
    SUM(dt.distancia_total) / 1000 AS KilometrosRecorridos
FROM distancia_total dt
JOIN ParticipanteUNAM pu
    ON pu.IdPersona = dt.IdPersona
GROUP BY
    pu.Facultad,
    pu.Sexo
ORDER BY
    pu.Facultad,
    pu.Sexo;

-- 2. Top 5 pokemones mas registrados en el torneo de peleas 
WITH Conteo AS (
    SELECT
        tp.Edicion,
        u.IdPokemon,
        p.Nombre AS NombrePokemon,
        COUNT(*) AS VecesRegistrado
    FROM TorneoPelea tp
    JOIN Utilizar u 
        ON u.Edicion = tp.Edicion 
        AND u.IdTorneo = tp.IdTorneo
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
    FROM InscripcionTorneoCaptura
),
participantes_distancia AS (
    SELECT DISTINCT IdPersona
    FROM InscripcionTorneoDistancia
)
SELECT 
    pu.IdPersona,
    pu.Nombre || ' ' || pu.ApellidoPaterno || ' ' || pu.ApellidoMaterno AS NombreCompleto
FROM ParticipanteUNAM pu
JOIN participantes_shiny s
    ON pu.IdPersona = s.IdPersona
LEFT JOIN participantes_distancia d
    ON pu.IdPersona = d.IdPersona
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
FROM registrar r 
JOIN pokemon p 
    ON p.idpokemon = r.idpokemon 
JOIN capturapokemon c 
    ON c.edicion = r.edicion
    AND r.idtorneo = c.idtorneo
    AND r.idcaptura = c.idcaptura
WHERE
    p.shiny = TRUE
    AND EXTRACT(HOUR FROM r.hora) BETWEEN 14 AND 18;

-- 7.(practica) Obtener el nombre completo de los participantes y su facultad que hayan participado tanto en el 
-- torneo de distancia recorrida como en el de captura de shinys (en la misma edición), cuya distancia total recorrida sea mayor 
-- al promedio de distancia de todos los participantes y ademas que su numero de capturas de shinys sean mayor a 5.
WITH participantes AS (
    SELECT DISTINCT 
        c.IdPersona, 
        c.CodigoDeEntrenador, 
        c.Edicion
    FROM InscripcionTorneoCaptura c
    JOIN InscripcionTorneoDistancia d
        ON c.IdPersona = d.IdPersona
        AND c.Edicion = d.Edicion
)
SELECT 
    pu.Nombre || ' ' || pu.ApellidoPaterno || ' ' || pu.ApellidoMaterno AS NombreCompleto,
    pu.Facultad,
    p.Edicion,
    distancia_total_entrenador(p.Edicion, p.CodigoDeEntrenador) AS DistanciaTotal,
    contar_shinys_cuenta(p.Edicion, NULL, p.IdPersona, p.CodigoDeEntrenador) AS NumeroShinys
FROM participantes p
JOIN ParticipanteUNAM pu
    ON pu.IdPersona = p.IdPersona
WHERE 
    contar_shinys_cuenta(p.Edicion, NULL, p.IdPersona, p.CodigoDeEntrenador) > 5
    AND distancia_total_entrenador(p.Edicion, p.CodigoDeEntrenador) > (
        SELECT AVG(distancia_total_entrenador(d.Edicion, d.CodigoDeEntrenador))
        FROM InscripcionTorneoDistancia d
    );

-- 8.(practica) Calcular la distancia total recorrida por cada participante en el torneo de distancia recorrida en kilómetros por torneo y edición, 
-- utilizando las coordenadas geográficas de cada locación. Ordenados de mayor a menor distancia.
SELECT
    d.Edicion,
    d.CodigoDeEntrenador,
    p.IdPersona,
    p.Nombre || ' ' || p.ApellidoPaterno || ' ' || p.ApellidoMaterno AS NombreCompleto,
    distancia_total_entrenador(d.Edicion, d.CodigoDeEntrenador) / 1000 AS KilometrosRecorridos
FROM DistanciaRecorrida d
JOIN ParticipanteUNAM p 
    ON p.IdPersona = d.IdPersona
GROUP BY 
    d.Edicion, 
    d.CodigoDeEntrenador, 
    p.IdPersona, 
    p.Nombre, 
    p.ApellidoPaterno, 
    p.ApellidoMaterno
ORDER BY KilometrosRecorridos DESC;

-- 9. Porcentaje de victorias por sexo/género en todos los torneos.
WITH Ganadores AS (
    SELECT IdPersona FROM TorneoPelea WHERE IdPersona IS NOT NULL
    UNION ALL
    SELECT IdPersona FROM TorneoDistanciaRecorrida WHERE IdPersona IS NOT NULL
    UNION ALL
    SELECT IdPersona FROM TorneoCapturaShinys WHERE IdPersona IS NOT NULL
),
ConteoPorSexo AS (
    SELECT 
        pu.Sexo,
        COUNT(*) AS Cantidad
    FROM Ganadores g
    JOIN ParticipanteUNAM pu 
        ON g.IdPersona = pu.IdPersona
    GROUP BY pu.Sexo
),
TotalGanadores AS (
    SELECT SUM(Cantidad) AS Total FROM ConteoPorSexo
)
SELECT 
    c.Sexo,
    c.Cantidad AS Victorias,
    ROUND((c.Cantidad::DECIMAL / t.Total) * 100, 2) AS PorcentajeVictorias
FROM ConteoPorSexo c
CROSS JOIN TotalGanadores t
ORDER BY PorcentajeVictorias DESC;

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
with ganadores
-- 12. Porcentaje de pokemones por tipo capturados en el torneo de captura.

-- 13. El jugador que más peleas perdió en el torneo de peleas.

-- 14. Porcentaje de participantes por facultad inscritos en cada torneo.
WITH TotalParticipantes AS (
    SELECT COUNT(DISTINCT IdPersona) AS Total FROM ParticipanteUNAM
),
ParticionatesDistancia AS (
    SELECT 
        facultad, 
        count(DISTINCT InscripcionTorneoDistancia.IdPersona) AS CantidadParticipantes
    FROM InscripcionTorneoDistancia INNER JOIN ParticipanteUNAM 
        ON InscripcionTorneoDistancia.IdPersona = ParticipanteUNAM.IdPersona
    GROUP BY facultad
),
ParticionatesPelea AS (
     SELECT 
        facultad, 
        count(DISTINCT InscripcionTorneoPelea.IdPersona) AS CantidadParticipantes
    FROM InscripcionTorneoPelea INNER JOIN ParticipanteUNAM 
        ON InscripcionTorneoPelea.IdPersona = ParticipanteUNAM.IdPersona
    GROUP BY facultad
),
ParticipnatesCapturas AS (
    SELECT 
        facultad, 
        count(DISTINCT InscripcionTorneoCaptura.IdPersona) AS CantidadParticipantes
    FROM InscripcionTorneoCaptura INNER JOIN ParticipanteUNAM 
        ON InscripcionTorneoCaptura.IdPersona = ParticipanteUNAM.IdPersona
    GROUP BY facultad
) SELECT 
    'Distancia Recorrida' AS Torneo,
    pd.facultad,
    ROUND((pd.CantidadParticipantes::DECIMAL / tp.Total) * 100, 2) AS PorcentajeParticipantes
FROM ParticionatesDistancia pd, TotalParticipantes tp
UNION ALL
SELECT 
    'Pelea' AS Torneo,  
    pp.facultad,
    ROUND((pp.CantidadParticipantes::DECIMAL / tp.Total) * 100, 2) AS PorcentajeParticipantes
FROM ParticionatesPelea pp, TotalParticipantes tp
UNION ALL
SELECT 
    'Captura de Shinys' AS Torneo,  
    pc.facultad,
    ROUND((pc.CantidadParticipantes::DECIMAL / tp.Total) * 100, 2) AS PorcentajeParticipantes
FROM ParticipnatesCapturas pc, TotalParticipantes tp
ORDER BY Torneo, facultad;  
    

-- 15. Porcentaje de pokemones shinys capturados por sexo/género de los participantes en el torneo de captura de shinys.

-- 16. Listar los pokemones que han sido usados en más de un torneo, indicando en cuántos torneos han sido usados.

-- 17. Listar los participantes que han ganado en más de un torneo, indicando en cuántos torneos han ganado.


-- participantes que han ganado en más de un torneo pelea, distancia, shiny
SELECT 
    pu.Nombre || ' ' || pu.ApellidoPaterno || ' ' || pu.ApellidoMaterno AS NombreCompleto,
    COUNT(*) AS TorneosGanados
FROM (
    SELECT IdPersona FROM TorneoPelea
    UNION ALL
    SELECT IdPersona FROM TorneoDistanciaRecorrida
    UNION ALL
    SELECT IdPersona FROM TorneoCapturaShinys
) AS tp
JOIN ParticipanteUNAM pu 
    ON tp.IdPersona = pu.IdPersona
GROUP BY 
    pu.Nombre, 
    pu.ApellidoPaterno, 
    pu.ApellidoMaterno
HAVING COUNT(*) > 0
ORDER BY TorneosGanados DESC;

-- SELECT 
--     pu.Nombre || ' ' || pu.ApellidoPaterno || ' ' || pu.ApellidoMaterno AS NombreCompleto,
--     COUNT(*) AS TorneosGanados
-- FROM TorneoPelea tp
-- JOIN ParticipanteUNAM pu 
--     ON tp.IdPersona = pu.IdPersona
-- GROUP BY 
--     pu.Nombre, 
--     pu.ApellidoPaterno, 
--     pu.ApellidoMaterno
-- HAVING COUNT(*) > 1
-- ORDER BY TorneosGanados DESC;

