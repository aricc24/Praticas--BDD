docker exec -i postgres psql -U postgres -d prueba < Eventos.sql
docker exec -i postgres psql -U postgres -d prueba < ParticipanteUNAM.sql
docker exec -i postgres psql -U postgres -d prueba < CorreoParticipante.sql
docker exec -i postgres psql -U postgres -d prueba < TelefonoParticipante.sql
docker exec -i postgres psql -U postgres -d prueba < CuentaPokemon.sql
docker exec -i postgres psql -U postgres -d prueba < Pokemon.sql


docker exec -i postgres psql -U postgres -d prueba < Vendedor.sql
docker exec -i postgres psql -U postgres -d prueba < Alimentos.sql
docker exec -i postgres psql -U postgres -d prueba < Espectador.sql
docker exec -i postgres psql -U postgres -d prueba < Asistir.sql