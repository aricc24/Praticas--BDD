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
docker exec -i postgres psql -U postgres -d prueba < Locacion.sql     2> errores/Locacion.err
docker exec -i postgres psql -U postgres -d prueba < distancia_recorrida.sql    2> errores/distancia_recorrida.err

docker exec -i postgres psql -U postgres -d prueba < registrar.sql    2> errores/registrar.err
docker exec -i postgres psql -U postgres -d prueba < peleas.sql    2> errores/peleas.err
docker exec -i postgres psql -U postgres -d prueba < utilizar.sql    2> errores/utilizar.err

docker exec -i postgres psql -U postgres -d prueba < comprar_espectador.sql    2> errores/comprar_espectador.err
docker exec -i postgres psql -U postgres -d prueba < comprar_participante_unam.sql    2> errores/comprar_participante_unam.err
docker exec -i postgres psql -U postgres -d prueba < comprar_vendedor.sql    2> errores/comprar_vendedor.err
docker exec -i postgres psql -U postgres -d prueba < comprar_cuidador.sql    2> errores/comprar_cuidador.err
docker exec -i postgres psql -U postgres -d prueba < comprar_encargado_registro.sql    2> errores/comprar_encargado_registro.err
docker exec -i postgres psql -U postgres -d prueba < comprar_limpiador.sql    2> errores/comprar_limpiador.err


cat Evento.sql               >  ../SQL/dml_torneo_pokemon.sql
cat ParticipanteUNAM.sql      >> ../SQL/dml_torneo_pokemon.sql
cat CorreoParticipante.sql    >> ../SQL/dml_torneo_pokemon.sql
cat TelefonoParticipante.sql  >> ../SQL/dml_torneo_pokemon.sql
cat limpiador.sql             >> ../SQL/dml_torneo_pokemon.sql
cat correo_limpiador.sql      >> ../SQL/dml_torneo_pokemon.sql
cat telefono_limpiador.sql    >> ../SQL/dml_torneo_pokemon.sql
cat trabajar_limpiador.sql    >> ../SQL/dml_torneo_pokemon.sql
cat cuidador.sql              >> ../SQL/dml_torneo_pokemon.sql
cat correo_cuidador.sql       >> ../SQL/dml_torneo_pokemon.sql      
cat telefono_cuidador.sql     >> ../SQL/dml_torneo_pokemon.sql  
cat trabajar_cuidador.sql     >> ../SQL/dml_torneo_pokemon.sql  
cat encargado_registro.sql         >> ../SQL/dml_torneo_pokemon.sql
cat correo_encargado_registro.sql  >> ../SQL/dml_torneo_pokemon.sql
cat telefono_encargado_registro.sql >> ../SQL/dml_torneo_pokemon.sql
cat trabajar_encargado_registro.sql >> ../SQL/dml_torneo_pokemon.sql
cat CuentaPokemon.sql         >> ../SQL/dml_torneo_pokemon.sql
cat Pokemon.sql               >> ../SQL/dml_torneo_pokemon.sql
cat vendedor.sql              >> ../SQL/dml_torneo_pokemon.sql
cat correo_vendedor.sql       >> ../SQL/dml_torneo_pokemon.sql
cat telefono_vendedor.sql     >> ../SQL/dml_torneo_pokemon.sql
cat trabajar_vendedor.sql     >> ../SQL/dml_torneo_pokemon.sql
cat Alimentos.sql             >> ../SQL/dml_torneo_pokemon.sql
cat Espectador.sql            >> ../SQL/dml_torneo_pokemon.sql
cat Asistir.sql               >> ../SQL/dml_torneo_pokemon.sql
cat CapturasPokemon.sql       >> ../SQL/dml_torneo_pokemon.sql
cat inscripcionEncargado.sql  >> ../SQL/dml_torneo_pokemon.sql
cat inscribirtorneocaptura.sql   >> ../SQL/dml_torneo_pokemon.sql
cat inscribirtorneodistancia.sql >> ../SQL/dml_torneo_pokemon.sql
cat inscribirtorneopelea.sql      >> ../SQL/dml_torneo_pokemon.sql
cat inscribirtorneocapturadistancia.sql >> ../SQL/dml_torneo_pokemon.sql
cat Locacion.sql               >> ../SQL/dml_torneo_pokemon.sql 
cat distancia_recorrida.sql    >> ../SQL/dml_torneo_pokemon.sql
cat registrar.sql              >> ../SQL/dml_torneo_pokemon.sql
cat peleas.sql                 >> ../SQL/dml_torneo_pokemon.sql
cat utilizar.sql               >> ../SQL/dml_torneo_pokemon.sql
cat comprar_espectador.sql        >> ../SQL/dml_torneo_pokemon.sql
cat comprar_participante_unam.sql >> ../SQL/dml_torneo_pokemon.sql
cat comprar_vendedor.sql         >> ../SQL/dml_torneo_pokemon.sql
cat comprar_cuidador.sql         >> ../SQL/dml_torneo_pokemon.sql
cat comprar_encargado_registro.sql >> ../SQL/dml_torneo_pokemon.sql
cat comprar_limpiador.sql        >> ../SQL/dml_torneo_pokemon.sql
