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

-- 1. Calcular la distancia total recorrida en kilómetros por los participantes de cada facultad, desglosada por sexo / género.
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

-- 2. Top 5 pokemones mas registrados en el torneo de peleas por cada edición y el top 5 global
WITH TopGlobal AS (
    SELECT
        u.IdPokemon,
        p.Nombre AS NombrePokemon,
        COUNT(*) AS VecesRegistrado
    FROM Utilizar u
    JOIN Pokemon p 
        ON p.IdPokemon = u.IdPokemon
    GROUP BY u.IdPokemon, p.Nombre
),
Conteo AS (
    SELECT
        tp.Edicion::text AS Edicion,
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
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY Edicion
            ORDER BY VecesRegistrado DESC
        ) AS rn
    FROM Conteo
),
TopGlobal5 AS (
    SELECT *
    FROM TopGlobal
    ORDER BY VecesRegistrado DESC
    LIMIT 5
),

-- Unión con columna de orden extra
Unioned AS (
    SELECT
        Edicion,
        IdPokemon,
        NombrePokemon,
        VecesRegistrado,
        Edicion::int AS OrdenEdicion
    FROM Top5
    WHERE rn <= 5

    UNION ALL

    SELECT
        'GLOBAL' AS Edicion,
        IdPokemon,
        NombrePokemon,
        VecesRegistrado,
        999999 AS OrdenEdicion
    FROM TopGlobal5
)

-- SELECT final sin mostrar columna extra
SELECT
    Edicion,
    IdPokemon,
    NombrePokemon,
    VecesRegistrado
FROM Unioned
ORDER BY OrdenEdicion, VecesRegistrado DESC;


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
-- no hechecado

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

WITH Ganancia AS (
    SELECT
        v.IdPersona AS IdVendedor,
        SUM(calcular_ventas_vendedor(v.IdPersona, tv.Edicion)) AS GananciaTotal
    FROM Vendedor v
    JOIN TrabajarVendedor tv ON tv.IdPersona = v.IdPersona
    GROUP BY v.IdPersona
)

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


SELECT 
    pu.Nombre || ' ' || pu.ApellidoPaterno || ' ' || pu.ApellidoMaterno AS NombreCompleto,
FROM peleatorneo pt
INNER JOINT Pokemon p
    ON pt.IdPokemon = p.IdPokemon
INNER JOIN CuentaPokemonGo cpg
    ON pt.CodigoDeEntrenador = cpg.CodigoDeEntrenador
INNER JOIN ParticipanteUNAM pu
    ON cpg.IdPersona = pu.IdPersona
WHERE pt.idPersona <> p.IdPersona
GROUP BY pu.IdPersona


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
WITH TotalCapturas AS (
    SELECT 
        pu.Sexo,
        COUNT(*) AS TotalCapturas
    FROM Registrar r
    JOIN ParticipanteUNAM pu ON r.IdPersona = pu.IdPersona
    JOIN CapturaPokemon c ON r.Edicion = c.Edicion AND r.IdTorneo = c.IdTorneo AND r.IdCaptura = c.IdCaptura
    GROUP BY pu.Sexo
),
CapturasShinys AS (
    SELECT 
        pu.Sexo,
        COUNT(*) AS CapturasShinys
    FROM Registrar r
    JOIN ParticipanteUNAM pu ON r.IdPersona = pu.IdPersona
    JOIN CapturaPokemon c ON r.Edicion = c.Edicion AND r.IdTorneo = c.IdTorneo AND r.IdCaptura = c.IdCaptura
    JOIN Pokemon p ON r.IdPokemon = p.IdPokemon
    WHERE p.Shiny = TRUE
    GROUP BY pu.Sexo
)
SELECT 
    tc.Sexo,
    tc.TotalCapturas,
    cs.CapturasShinys,
    ROUND((cs.CapturasShinys::DECIMAL / tc.TotalCapturas) * 100, 2) AS PorcentajeShinys
FROM TotalCapturas tc
LEFT JOIN CapturasShinys cs ON tc.Sexo = cs.Sexo
ORDER BY tc.Sexo;

-- 16. Listar los pokemones que han sido usados en más de un torneo, indicando en cuántos torneos han sido usados.

WITH UsoPokemon AS (
    SELECT 
        u.IdPokemon,
        COUNT(DISTINCT u.Edicion || '-' || u.IdTorneo) AS CantidadTorneos
    FROM Utilizar u
    GROUP BY u.IdPokemon
    HAVING COUNT(DISTINCT u.Edicion || '-' || u.IdTorneo) > 1
)
SELECT 
    p.IdPokemon,
    p.Nombre,
    up.CantidadTorneos
FROM UsoPokemon up 
JOIN Pokemon p ON up.IdPokemon = p.IdPokemon
ORDER BY up.CantidadTorneos DESC, p.Nombre;

-- 17. Listar los participantes que han ganado en más de un torneo, indicando en cuántos torneos han ganado.

WITH Ganadores AS (
    SELECT IdPersona, Edicion || '-' || IdTorneo AS Torneo FROM TorneoPelea WHERE IdPersona IS NOT NULL
    UNION ALL
    SELECT IdPersona, Edicion || '-' || IdTorneo AS Torneo FROM TorneoDistanciaRecorrida WHERE IdPersona IS NOT NULL
    UNION ALL
    SELECT IdPersona, Edicion || '-' || IdTorneo AS Torneo FROM TorneoCapturaShinys WHERE IdPersona IS NOT NULL
),
ConteoGanadores AS (
    SELECT 
        g.IdPersona,
        COUNT(DISTINCT g.Torneo) AS CantidadTorneosGanados
    FROM Ganadores g
    GROUP BY g.IdPersona
    HAVING COUNT(DISTINCT g.Torneo) > 1
)
SELECT 
    pu.IdPersona,
    pu.Nombre || ' ' || pu.ApellidoPaterno || ' ' || pu.ApellidoMaterno AS NombreCompleto,
    cg.CantidadTorneosGanados
FROM ConteoGanadores cg
JOIN ParticipanteUNAM pu ON cg.IdPersona = pu.IdPersona
ORDER BY cg.CantidadTorneosGanados DESC, pu.Nombre;

-- Calcular las ganancias totales por vendedor, ordenadas de mayor a menor ganancia.
WITH Ganancias AS (
    SELECT
        v.IdPersona AS IdVendedor,
        SUM(calcular_ventas_vendedor(v.IdPersona, tv.Edicion)) AS GananciaTotal
    FROM Vendedor v
    JOIN TrabajarVendedor tv ON tv.IdPersona = v.IdPersona
    GROUP BY v.IdPersona
)

SELECT
    v.IdPersona,
    v.Nombre || ' ' || v.ApellidoPaterno || ' ' || v.ApellidoMaterno AS NombreCompleto,
    g.GananciaTotal
FROM Vendedor v
LEFT JOIN Ganancias g ON g.IdVendedor = v.IdPersona
ORDER BY g.GananciaTotal DESC;


-- Calcular el gasto promedio por rol en los eventos.
WITH Gastos AS (
    SELECT *
    FROM (
        SELECT tc.Edicion AS Edicion,
            'cuidador' AS Rol,
            (SELECT MontoConIVA
                FROM total_compras_persona(tc.IdPersona,'cuidador',tc.Edicion)
            ) AS gasto
        FROM TrabajarCuidador tc
    ) gc
    WHERE gc.gasto > 0

    UNION ALL

    SELECT *
    FROM (
        SELECT tl.Edicion AS Edicion,
            'limpiador' AS Rol,
            (SELECT MontoConIVA
                FROM total_compras_persona(tl.IdPersona,'limpiador',tl.Edicion)
            ) AS gasto
        FROM TrabajarLimpiador tl
        GROUP BY tl.Edicion, tl.IdPersona
    ) gl
    WHERE gl.gasto > 0

    UNION ALL

    SELECT *
    FROM (
        SELECT er.Edicion AS Edicion,
            'encargadoregistro' AS Rol,
            (SELECT MontoConIVA
                FROM total_compras_persona(er.IdPersona,'encargadoregistro',er.Edicion)
            ) AS gasto
        FROM TrabajarEncargadoRegistro er
    ) ger
    WHERE ger.gasto > 0

    UNION ALL

    SELECT *
    FROM (
        SELECT pe.Edicion AS Edicion,
            'participanteunam' AS Rol,
            (SELECT MontoConIVA
                FROM total_compras_persona(pe.IdPersona,'participanteunam',pe.Edicion)
            ) AS gasto
        FROM ParticipanteInscribirEvento pe
    ) gpe   
    WHERE gpe.gasto > 0

    UNION ALL

    SELECT *
    FROM (
        SELECT a.Edicion AS Edicion,
            'espectador' AS Rol,
            (SELECT MontoConIVA
                FROM total_compras_persona(a.IdPersona,'espectador',a.Edicion)
            ) AS gasto
        FROM Asistir a
    ) ga
    WHERE ga.gasto > 0
)
SELECT rol, AVG(gasto) AS gasto_promedio
FROM Gastos
GROUP BY rol
ORDER BY rol, gasto_promedio DESC;
