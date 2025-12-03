mkdir -p errores
docker exec -i postgres psql -U postgres -d prueba < Evento.sql                2> errores/Evento.err
docker exec -i postgres psql -U postgres -d prueba < ParticipanteUNAM.sql       2> errores/ParticipanteUNAM.err
docker exec -i postgres psql -U postgres -d prueba < CorreoParticipante.sql     2> errores/CorreoParticipante.err
docker exec -i postgres psql -U postgres -d prueba < TelefonoParticipante.sql   2> errores/TelefonoParticipante.err

docker exec -i postgres psql -U postgres -d prueba < limpiador.sql              2> errores/limpiador.err
docker exec -i postgres psql -U postgres -d prueba < correo_limpiador.sql       2> errores/correo_limpiador.err
docker exec -i postgres psql -U postgres -d prueba < telefono_limpiador.sql     2> errores/telefono_limpiador.err
docker exec -i postgres psql -U postgres -d prueba < trabajar_limpiador.sql     2> errores/trabajar_limpiador.err

docker exec -i postgres psql -U postgres -d prueba < cuidador.sql               2> errores/cuidador.err
docker exec -i postgres psql -U postgres -d prueba < correo_cuidador.sql        2> errores/correo_cuidador.err
docker exec -i postgres psql -U postgres -d prueba < telefono_cuidador.sql      2> errores/telefono_cuidador.err
docker exec -i postgres psql -U postgres -d prueba < trabajar_cuidador.sql      2> errores/trabajar_cuidador.err

docker exec -i postgres psql -U postgres -d prueba < encargado_registro.sql         2> errores/encargado_registro.err
docker exec -i postgres psql -U postgres -d prueba < correo_encargado_registro.sql  2> errores/correo_encargado_registro.err
docker exec -i postgres psql -U postgres -d prueba < telefono_encargado_registro.sql 2> errores/telefono_encargado_registro.err
docker exec -i postgres psql -U postgres -d prueba < trabajar_encargado_registro.sql 2> errores/trabajar_encargado_registro.err

docker exec -i postgres psql -U postgres -d prueba < CuentaPokemon.sql          2> errores/CuentaPokemon.err
docker exec -i postgres psql -U postgres -d prueba < Pokemon.sql                2> errores/Pokemon.err

docker exec -i postgres psql -U postgres -d prueba < vendedor.sql               2> errores/vendedor.err
docker exec -i postgres psql -U postgres -d prueba < correo_vendedor.sql        2> errores/correo_vendedor.err
docker exec -i postgres psql -U postgres -d prueba < telefono_vendedor.sql      2> errores/telefono_vendedor.err
docker exec -i postgres psql -U postgres -d prueba < trabajar_vendedor.sql      2> errores/trabajar_vendedor.err

docker exec -i postgres psql -U postgres -d prueba < Alimentos.sql              2> errores/Alimentos.err
docker exec -i postgres psql -U postgres -d prueba < Espectador.sql             2> errores/Espectador.err
docker exec -i postgres psql -U postgres -d prueba < Asistir.sql                2> errores/Asistir.err
docker exec -i postgres psql -U postgres -d prueba < CapturasPokemon.sql        2> errores/CapturasPokemon.err
docker exec -i postgres psql -U postgres -d prueba < inscripcionEncargado.sql   2> errores/inscripcionEncargado.err


docker exec -i postgres psql -U postgres -d prueba < inscribirtorneocaptura.sql   2> errores/inscribirtorneocaptura.err
docker exec -i postgres psql -U postgres -d prueba < inscribirtorneodistancia.sql   2> errores/inscribirtorneodistancia.err
docker exec -i postgres psql -U postgres -d prueba < inscribirtorneopelea.sql     2> errores/inscribirtorneopelea.err
docker exec -i postgres psql -U postgres -d prueba < inscribirtorneocapturadistancia.sql     2> errores/inscribirtorneocapturadistancia.err