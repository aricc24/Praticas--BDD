-- i. Mostrar el nombre completo de todos los participantes junto con su cuenta de Pokémon Go.
-- ii. Calcular cuántos Pokémons registró cada participante para el torneo de peleas por cada una de las ediciones.
-- iii. Listar todos los Pokémones cuya especie contenga la cadena ćhu ́
-- .

-- iv. Obtener la lista de participantes que estén inscritos en el Torneo de Captura de Shiny y a su vez que no estén
-- inscritos en el torneo de distancia recorrida.
-- v. Calcular la distancia total recorrida por cada participante en el torneo de distancia recorrida.
SELECT
    p.nombre,
    p.apellidopaterno,
    p.apellidomaterno,
    dr.idparticipante,
    SUM(dr.distancia) AS distancia_total
FROM
    DistanciaRecorrida dr JOIN ParticipanteUNAM p ON dr.idparticipante = p.idparticipante
    JOIN TorneoDistanciaRecorrida t ON dr.idTorneoDistancia = t.idTorneoDistancia
GROUP BY
    p.nombre,
    p.apellidopaterno,
    p.apellidomaterno
    dr.idparticipante
ORDER BY
    distancia_total
-- vi. Listar los Pokémones shinys, que fueron capturados durante el evento, únicamente si fueron capturados entre
-- las 14:00hrs y las 18:00hrs.
SELECT
    p.nombre AS nombre,
    p.tipo,
    p.shiny,
    c.fechacaptura,
    c.horacaptura,
    e.edicion AS evento
FROM
    CapturaPokemon c JOIN Pokemon p ON c.idpokemon = p.idpokemon 
    JOIN Evento e ON c.idevento = e.idevento
WHERE
    p.shiny = TRUE AND c.idevento IS NOT NULL 
    AND c.horacaptura BETWEEN '14:00:00' AND '18:00:00'
-- vii. Mostrar a todos los vendedores junto con los alimentos que venden, indicando el precio sin IVA y el precio final
-- con IVA del 16 %.
-- viii. Mostrar las facultades que tienen más de 5 participantes inscritos en cualquier torneo.
-- ix. Listar a los vendedores cuyo total de alimentos de alimentos vendidos (número de productos distintos que ofrecen) sea mayor a 3.
SELECT v.* FROM Vendedor v JOIN Alimento a ON v.IdPersona = a.IdPersona GROUP BY v.IdPersona HAVING COUNT(DISTINCT a.IdAlimento) > 3;
-- x. Obtener el nombre completo de los participantes y su facultad que hayan participado tanto en el torneo de distancia recorrida como en el de captura de shinys, cuya distancia total recorrida sea mayor al promedio de distancia de todos los participantes y ademas que su numero de capturas de shinys sean mayor a 5.