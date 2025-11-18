import re

# ---------------------------------------------------------
# 1. Pega aquí el bloque largo de INSERTs tal cual
# ---------------------------------------------------------
data = """
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (84, 138, 'Valor', 47, 'nmcgoldrick0');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (128, 148, 'Sabiduría', 41, 'pocaherny1');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (39, 43, 'Instinto', 88, 'twinckle2');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (65, 63, 'Instinto', 95, 'celcoux3');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (121, 126, 'Instinto', 32, 'eswetenham4');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (21, 132, 'Sabiduría', 7, 'wcookney5');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (115, 12, 'Sabiduría', 29, 'jlorant6');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (117, 95, 'Instinto', 49, 'amccard7');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (29, 33, 'Valor', 2, 'ewenderott8');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (144, 17, 'Instinto', 50, 'kjeannot9');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (22, 84, 'Valor', 46, 'dashlinga');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (141, 30, 'Instinto', 27, 'ssimpsonb');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (142, 105, 'Instinto', 39, 'gpanswickc');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (83, 45, 'Sabiduría', 11, 'bdebiasid');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (24, 8, 'Sabiduría', 43, 'fmcgoniglee');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (132, 144, 'Instinto', 99, 'sstangelf');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (120, 140, 'Instinto', 61, 'acasheng');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (48, 130, 'Instinto', 78, 'gmilhenchh');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (82, 63, 'Valor', 93, 'iklimpti');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (150, 28, 'Sabiduría', 63, 'lcocktonj');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (115, 146, 'Sabiduría', 48, 'hpothecaryk');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (28, 107, 'Valor', 97, 'clinguardl');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (131, 39, 'Valor', 79, 'kohanessianm');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (109, 115, 'Valor', 88, 'gellsen');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (92, 7, 'Valor', 32, 'ddykeso');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (109, 139, 'Instinto', 45, 'gmaypolep');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (60, 130, 'Instinto', 97, 'hmenceq');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (82, 135, 'Instinto', 17, 'fpiserr');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (100, 119, 'Instinto', 18, 'aaubins');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (45, 109, 'Valor', 99, 'oderrettt');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (109, 124, 'Sabiduría', 25, 'efaugheyu');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (111, 49, 'Sabiduría', 43, 'rfortyev');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (74, 115, 'Valor', 91, 'sdungatew');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (97, 60, 'Valor', 15, 'cjeannetx');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (57, 92, 'Valor', 64, 'gmarklowy');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (69, 70, 'Sabiduría', 62, 'deneverz');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (68, 108, 'Valor', 43, 'abolle10');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (51, 50, 'Instinto', 50, 'jbeldon11');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (40, 14, 'Sabiduría', 13, 'ktyrrell12');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (85, 15, 'Valor', 5, 'pmuldoon13');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (72, 10, 'Sabiduría', 26, 'jwragge14');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (50, 125, 'Instinto', 15, 'esurgeoner15');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (49, 145, 'Instinto', 42, 'cmatys16');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (44, 4, 'Sabiduría', 73, 'vhuson17');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (126, 80, 'Valor', 29, 'sortner18');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (147, 136, 'Valor', 24, 'fgallaher19');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (106, 50, 'Valor', 72, 'wcrus1a');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (84, 113, 'Instinto', 8, 'isambidge1b');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (74, 140, 'Valor', 16, 'cnegro1c');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (80, 68, 'Valor', 36, 'awoodworth1d');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (5, 103, 'Valor', 88, 'enockells1e');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (79, 12, 'Sabiduría', 69, 'bretchford1f');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (62, 100, 'Sabiduría', 80, 'dfoye1g');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (115, 117, 'Valor', 98, 'wewer1h');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (148, 82, 'Sabiduría', 29, 'bbocke1i');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (144, 83, 'Sabiduría', 82, 'epunshon1j');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (74, 138, 'Sabiduría', 74, 'nfricke1k');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (29, 76, 'Sabiduría', 48, 'sarnaldy1l');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (131, 31, 'Sabiduría', 38, 'ggoldine1m');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (120, 126, 'Instinto', 36, 'mcampsall1n');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (26, 43, 'Sabiduría', 29, 'jstanlack1o');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (136, 45, 'Sabiduría', 31, 'phegerty1p');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (140, 13, 'Instinto', 36, 'hvecard1q');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (121, 44, 'Valor', 17, 'amingo1r');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (35, 9, 'Instinto', 58, 'sbozier1s');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (118, 134, 'Instinto', 50, 'fblackey1t');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (19, 146, 'Sabiduría', 31, 'jbahike1u');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (34, 75, 'Instinto', 80, 'mduggleby1v');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (83, 78, 'Instinto', 30, 'avairow1w');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (100, 83, 'Valor', 42, 'bgillis1x');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (55, 88, 'Sabiduría', 93, 'gduchant1y');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (59, 39, 'Valor', 50, 'mlevins1z');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (52, 19, 'Sabiduría', 78, 'gkirdsch20');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (118, 120, 'Valor', 69, 'cmartynov21');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (104, 55, 'Instinto', 23, 'scancelier22');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (78, 12, 'Instinto', 15, 'lmcsparran23');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (29, 18, 'Valor', 15, 'cbrislawn24');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (67, 88, 'Sabiduría', 79, 'gcastagnier25');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (2, 74, 'Sabiduría', 46, 'aneath26');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (100, 139, 'Sabiduría', 93, 'glowdeane27');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (123, 60, 'Sabiduría', 17, 'mtibbles28');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (31, 66, 'Sabiduría', 32, 'mhould29');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (148, 24, 'Sabiduría', 98, 'rshrive2a');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (62, 57, 'Valor', 77, 'cvancassel2b');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (34, 111, 'Instinto', 75, 'nlanaway2c');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (75, 91, 'Valor', 19, 'jderham2d');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (94, 86, 'Sabiduría', 47, 'kknipe2e');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (33, 68, 'Sabiduría', 32, 'vmushett2f');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (65, 148, 'Sabiduría', 59, 'pbodycombe2g');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (130, 93, 'Sabiduría', 95, 'hroyden2h');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (120, 52, 'Sabiduría', 91, 'mshieber2i');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (3, 27, 'Sabiduría', 45, 'abollin2j');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (100, 90, 'Instinto', 51, 'jwofenden2k');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (148, 131, 'Valor', 40, 'uroughley2l');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (80, 114, 'Sabiduría', 83, 'ecatmull2m');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (3, 146, 'Sabiduría', 82, 'dchritchley2n');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (45, 104, 'Valor', 91, 'ddrewell2o');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (72, 35, 'Sabiduría', 18, 'lmcevilly2p');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (59, 45, 'Valor', 78, 'lbarenski2q');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (149, 87, 'Sabiduría', 28, 'mwheeliker2r');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (110, 96, 'Sabiduría', 20, 'ncashin2s');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (90, 77, 'Valor', 28, 'cbernadzki2t');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (1, 32, 'Sabiduría', 46, 'ipester2u');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (85, 137, 'Sabiduría', 86, 'dtick2v');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (119, 88, 'Sabiduría', 85, 'aifill2w');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (21, 121, 'Sabiduría', 97, 'kbenoey2x');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (71, 18, 'Valor', 80, 'llowin2y');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (102, 133, 'Instinto', 56, 'ffeaver2z');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (118, 59, 'Sabiduría', 47, 'tbarnaby30');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (39, 24, 'Sabiduría', 59, 'jbalchen31');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (61, 32, 'Instinto', 84, 'rstanner32');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (57, 52, 'Instinto', 53, 'sbengtson33');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (62, 114, 'Valor', 47, 'gpiddick34');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (98, 54, 'Valor', 41, 'scalderwood35');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (5, 58, 'Sabiduría', 22, 'blowndsbrough36');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (107, 73, 'Instinto', 86, 'gleward37');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (123, 93, 'Sabiduría', 64, 'lmiddleditch38');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (19, 85, 'Instinto', 24, 'baskie39');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (119, 55, 'Valor', 74, 'tbarnewille3a');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (25, 134, 'Sabiduría', 60, 'dbrodie3b');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (92, 53, 'Sabiduría', 29, 'msmart3c');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (40, 137, 'Sabiduría', 55, 'ctewnion3d');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (67, 137, 'Sabiduría', 6, 'gedinburough3e');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (40, 121, 'Sabiduría', 30, 'gbresnahan3f');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (86, 95, 'Sabiduría', 42, 'gbowley3g');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (40, 48, 'Sabiduría', 34, 'pnice3h');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (3, 123, 'Instinto', 35, 'kmiles3i');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (149, 94, 'Sabiduría', 35, 'dkirsop3j');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (142, 98, 'Instinto', 24, 'spalfreyman3k');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (116, 103, 'Sabiduría', 63, 'jshapera3l');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (144, 64, 'Valor', 54, 'tnendick3m');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (5, 48, 'Valor', 75, 'jrosewall3n');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (38, 52, 'Valor', 83, 'mharler3o');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (115, 116, 'Instinto', 11, 'rbonde3p');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (45, 70, 'Sabiduría', 27, 'kwarrener3q');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (125, 64, 'Valor', 100, 'rgoodwell3r');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (97, 64, 'Instinto', 1, 'bpenhalewick3s');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (29, 65, 'Sabiduría', 98, 'ntuft3t');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (64, 16, 'Instinto', 79, 'kbollom3u');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (116, 99, 'Sabiduría', 30, 'hthunder3v');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (33, 64, 'Sabiduría', 4, 'nvalenta3w');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (51, 115, 'Sabiduría', 18, 'lcrichton3x');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (59, 27, 'Valor', 84, 'eshearwood3y');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (140, 31, 'Instinto', 7, 'acastaner3z');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (45, 80, 'Valor', 8, 'emiebes40');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (17, 115, 'Instinto', 79, 'lgricewood41');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (146, 127, 'Instinto', 11, 'rcousans42');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (135, 117, 'Valor', 22, 'zworsnip43');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (67, 48, 'Valor', 89, 'kjann44');
insert into CuentaPokemonGo (idpersona, codigodeentrenador, equipo, nivel, nombredeusuario) values (4, 20, 'Sabiduría', 42, 'dfrapwell45');

"""

# ---------------------------------------------------------
# 2. Expresión regular para extraer los valores
# ---------------------------------------------------------
pattern = re.compile(
    r"values\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*'([^']+)'\s*,\s*(\d+)\s*,\s*'([^']+)'\s*\)",
    re.IGNORECASE
)

# ---------------------------------------------------------
# 3. Parseo de todos los registros
# ---------------------------------------------------------
cuentas = {}
for match in pattern.finditer(data):
    idpersona = int(match.group(1))
    cod = int(match.group(2))
    equipo = match.group(3)
    nivel = int(match.group(4))
    username = match.group(5)

    cuentas[idpersona] = cod
    

# ---------------------------------------------------------
# 4. Ejemplo de impresión bonita
# ---------------------------------------------------------
print(f"Total de cuentas cargadas: {len(cuentas)}\n")

print(cuentas)

# Si quieres usar la lista completa:
# print(cuentas)
