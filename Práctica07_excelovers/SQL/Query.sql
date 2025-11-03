-- i. Participantes cuyo nombre empiece con la letra R.
SELECT * FROM participanteunam WHERE nombre LIKE 'R%';
-- ii. Alimentos que hayan caducado después del 3 de noviembre del 2025 pero antes del 10 de diciembre
-- del 2025.
-- iii. Cuidadores que hayan nacido en el mes de noviembre.
SELECT * FROM cuidador WHERE EXTRACT(MONTH FROM fechanacimiento) = 11;
-- iv. Pokemones cuya especie sea Jigglypuff y cuyo CP sea 818.
-- v. La diferentes especies de todos los Pokemones shinys que se tengan registradas..