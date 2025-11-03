-- i. Participantes cuyo nombre empiece con la letra R.
SELECT * FROM participanteunam WHERE UPPER(nombre) LIKE 'R%';
-- ii. Alimentos que hayan caducado después del 3 de noviembre del 2025 pero antes del 10 de diciembre
-- del 2025.
SELECT * FROM Alimento WHERE FechaDeCaducidad > '2025-11-03' AND FechaDeCaducidad < '2025-12-10'; 
-- iii. Cuidadores que hayan nacido en el mes de noviembre.
SELECT * FROM cuidador WHERE EXTRACT(MONTH FROM fechanacimiento) = 11;
-- iv. Pokemones cuya especie sea Jigglypuff y cuyo CP sea 818.
SELECT * FROM pokemon WHERE UPPER(especie) = 'JIGGLYPUFF' AND puntosdecombate = 818;
-- v. La diferentes especies de todos los Pokemones shinys que se tengan registradas.
SELECT DISTINCT especie FROM pokemon WHERE shiny = TRUE;