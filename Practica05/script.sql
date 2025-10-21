-- JULIETA 

-- ========
-- 1. Evento 
-- =======
CREATE TABLE Evento (
    Edicion INTEGER NOT NULL UNIQUE,
    Fecha DATE NOT NULL
);

ALTER TABLE Evento ADD CONSTRAINT pk_evento PRIMARY KEY (Edicion);


-- ========
-- 2. CuentaPokemon
-- =======

CREATE TABLE CuentaPokemonGo (
    IdPersona INTEGER NOT NULL,
    CodigoDeEntrenador INTEGER NOT NULL UNIQUE SERIAL,
    Equipo VARCHAR(20) NOT NULL,
    Nivel SMALLINT NOT NULL CHECK (Nivel >= 1),
    NombreDeUsuario VARCHAR(30) NOT NULL UNIQUE
);


ALTER TABLE CuentaPokemonGo ADD CONSTRAINT pk_cuenta_pokemon_go PRIMARY KEY (IdPersona, CodigoDeEntrenador);

ALTER TABLE CuentaPokemonGo ADD CONSTRAINT fk_cuenta_pokemon_go_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

-- ========
-- 3. Pokemon
-- =======
CREATE TABLE Pokemon (
    IdPokemon INTEGER NOT NULL UNIQUE SERIAL,
    IdPersona INTEGER NOT NULL,
    CodigoDeEntrenador INTEGER NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Sexo CHAR(10) NOT NULL CHECK (Sexo IN ('M', 'H', 'Otro')),
    Peso REAL NOT NULL CHECK (Peso > 0),
    PuntosDeCombate INTEGER NOT NULL CHECK (PuntosDeCombate >= 0),
    Shiny BOOLEAN NOT NULL,
    Tipo VARCHAR(20) NOT NULL,
    Especie VARCHAR(20) NOT NULL
);

ALTER TABLE Pokemon ADD CONSTRAINT pk_pokemon PRIMARY KEY (IdPokemon);

ALTER TABLE Pokemon ADD CONSTRAINT fk_pokemon_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador)
    REFERENCES CuentaPokemonGo (IdPersona, CodigoDeEntrenador);

-- ========
-- 4. TorneoCapturaShinys 
-- ========
CREATE TABLE TorneoCapturaShinys (
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL UNIQUE SERIAL,
    IdPersona INTEGER,
    CantidadAPremiar REAL DEFAULT 500.0
);
   
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT pk_torneo_captura_shinys PRIMARY KEY (Edicion, IdTorneo);
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT fk_torneo_captura_shinys_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT fk_torneo_captura_shinys_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

-- ========
-- 5. TorneoDistanciaRecorrida
-- ========
CREATE TABLE TorneoDistanciaRecorrida (
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL UNIQUE SERIAL,
    IdPersona INTEGER,
    CantidadAPremiar REAL DEFAULT 500.0
);

ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT pk_torneo_distancia_recorrida PRIMARY KEY (Edicion, IdTorneo);
ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT fk_torneo_distancia_recorrida_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);
ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT fk_torneo_distancia_recorrida_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

-- ========
-- 6. CapturaPokemon
-- ========
CREATE TABLE CapturaPokemon (
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL,
    IdCaptura INTEGER NOT NULL UNIQUE SERIAL
);


ALTER TABLE CapturaPokemon ADD CONSTRAINT pk_captura_pokemon PRIMARY KEY (Edicion, IdTorneo, IdCaptura);
ALTER TABLE CapturaPokemon ADD CONSTRAINT fk_captura_pokemon_torneo_captura_shinys FOREIGN KEY (Edicion, IdTorneo) REFERENCES TorneoCapturaShinys(Edicion, IdTorneo);

-- ========
-- 7. Registrar
-- ========
CREATE TABLE Registrar (
    IdPokemon INTEGER NOT NULL,
    CodigoDeEntrenador INTEGER NOT NULL,
    IdPersona INTEGER NOT NULL,
    IdCaptura INTEGER NOT NULL,
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIMETZ NOT NULL
);


ALTER TABLE Registrar ADD CONSTRAINT fk_registrar_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador);
ALTER TABLE Registrar ADD CONSTRAINT fk_registrar_captura_pokemon FOREIGN KEY (Edicion, IdTorneo, IdCaptura) REFERENCES CapturaPokemon(Edicion, IdTorneo, IdCaptura);
ALTER TABLE Registrar ADD CONSTRAINT fk_registrar_pokemon FOREIGN KEY (IdPokemon) REFERENCES Pokemon(IdPokemon);

-- ========
-- 8. DistanciaRecorrida
-- ========
CREATE TABLE DistanciaRecorrida (
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL,
    IdDistancia INTEGER NOT NULL UNIQUE SERIAL,
    IdPersona INTEGER NOT NULL,
    CodigoDeEntrenador INTEGER NOT NULL,
    Locación VARCHAR(10) NOT NULL CHECK (Locación IN ('Universum', 'Entrada', 'Rectoria')),
    Fecha DATE NOT NULL,
    Hora TIMETZ NOT NULL
);

ALTER TABLE DistanciaRecorrida ADD CONSTRAINT pk_distancia_recorrido PRIMARY KEY (Edicion, IdTorneo, IdDistancia);
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT fk_distancia_recorrida_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador);
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT fk_distancia_recorrida_torneo_distancia_recorrida FOREIGN KEY (Edicion, IdTorneo) REFERENCES TorneoDistanciaRecorrida(Edicion, IdTorneo);


--- JOSE ANTONIO
-- ========
-- 1. ComprarCuidador (Va después de Cuidador y Alimento)
-- ========
CREATE TABLE ComprarCuidador (
    IdPersona INTEGER NOT NULL,
    IdAlimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL NOT NULL CHECK (Cantidad > 0)
);
ALTER TABLE ComprarCuidador ADD CONSTRAINT fk_comprar_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona);
ALTER TABLE ComprarCuidador ADD CONSTRAINT fk_comprar_cuidador_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);

-- ========
-- 2. Limpiador 
-- =======
CREATE TABLE Limpiador (
    IdPersona INTEGER NOT NULL SERIAL UNIQUE,
    Nombre VARCHAR(20) NOT NULL,
    ApellidoMaterno VARCHAR(20) NOT NULL,
    ApellidoPaterno VARCHAR(20) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo VARCHAR(10) NOT NULL CHECK (Sexo IN ('M', 'H', 'Otro')),
    Calle VARCHAR(20) NOT NULL,
    Colonia VARCHAR(20) NOT NULL,
    Ciudad VARCHAR(20) NOT NULL,
    CodigoPostal INTEGER NOT NULL,
    NumInterior INTEGER,
    NumExterior INTEGER NOT NULL,
    Ubicacion VARCHAR(20),
    Horario VARCHAR(10) CHECK (Horario IN ('Matutino', 'Vespertino')),
    Salario REAL CHECK (Salario >= 0)
);
ALTER TABLE Limpiador ADD CONSTRAINT pk_limpiador PRIMARY KEY (IdPersona);

-- ========
-- 3. CorreoLimpiador (Va después de Limpiador)
-- =======
CREATE TABLE CorreoLimpiador (
    IdPersona INTEGER NOT NULL,
    Correo VARCHAR(50) NOT NULL
);
ALTER TABLE CorreoLimpiador ADD CONSTRAINT pk_correo_limpiador PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoLimpiador ADD CONSTRAINT fk_correo_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona);

-- ========
-- 4. TelefonoLimpiador (Va después de Limpiador)
-- =======
CREATE TABLE TelefonoLimpiador (
    IdPersona INTEGER NOT NULL,
    Telefono CHAR(10) NOT NULL
);
ALTER TABLE TelefonoLimpiador ADD CONSTRAINT pk_telefono_limpiador PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoLimpiador ADD CONSTRAINT fk_telefono_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona);

-- ========
-- 5. TrabajarLimpiador (Va después de Limpiador y Evento)
-- =======
CREATE TABLE TrabajarLimpiador (
    IdPersona INTEGER NOT NULL,
    Edicion INTEGER NOT NULL
);
ALTER TABLE TrabajarLimpiador ADD CONSTRAINT fk_trabajar_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona);
ALTER TABLE TrabajarLimpiador ADD CONSTRAINT fk_trabajar_limpiador_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);

-- ========
-- 6. ComprarLimpiador (Va después de Limpiador y Alimento) 
-- =======
CREATE TABLE ComprarLimpiador (
    IdPersona INTEGER NOT NULL,
    IdAlimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL NOT NULL CHECK (Cantidad > 0)
);
ALTER TABLE ComprarLimpiador ADD CONSTRAINT fk_comprar_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona);
ALTER TABLE ComprarLimpiador ADD CONSTRAINT fk_comprar_limpiador_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);

-- ========
-- 7. TorneoPelea (Va después de Evento y ParticipanteUNAM)
-- =======
CREATE TABLE TorneoPelea (
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL UNIQUE SERIAL,
    IdPersona INTEGER,
    CantidadAPremiar REAL DEFAULT 500.0
);
ALTER TABLE TorneoPelea ADD CONSTRAINT pk_torneo_pelea PRIMARY KEY (Edicion, IdTorneo);
ALTER TABLE TorneoPelea ADD CONSTRAINT fk_torneo_pelea_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);
ALTER TABLE TorneoPelea ADD CONSTRAINT fk_torneo_pelea_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

-- ========
-- 8. PeleaTorneo (Va después de TorneoPelea y CuentaPokemonGo)
-- =======
CREATE TABLE PeleaTorneo (
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL,
    NumeroPelea INTEGER NOT NULL SERIAL UNIQUE,
    IdPersona INTEGER,
    CodigoDeEntrenador INTEGER NOT NULL,
    Fecha DATE NOT NULL,
    Fase INTEGER NOT NULL
);
ALTER TABLE PeleaTorneo ADD CONSTRAINT pk_pelea_torneo PRIMARY KEY (Edicion, IdTorneo, NumeroPelea);
ALTER TABLE PeleaTorneo ADD CONSTRAINT fk_pelea_torneo_torneo FOREIGN KEY (Edicion, IdTorneo) REFERENCES TorneoPelea(Edicion, IdTorneo);
ALTER TABLE PeleaTorneo ADD CONSTRAINT fk_pelea_torneo_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador);

-- ========
-- 9. Utilizar (Va después de PeleaTorneo y Pokemon)
-- ========
CREATE TABLE Utilizar (
    IdPokemon INTEGER NOT NULL,
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL,
    NumeroPelea INTEGER NOT NULL,
);
ALTER TABLE Utilizar ADD CONSTRAINT fk_utilizar_pokemon FOREIGN KEY (IdPokemon) REFERENCES Pokemon(IdPokemon);
ALTER TABLE Utilizar ADD CONSTRAINT fk_utilizar_pelea_torneo FOREIGN KEY (Edicion, IdTorneo, NumeroPelea) REFERENCES PeleaTorneo(Edicion, IdTorneo, NumeroPelea);


---- ARI

-- ========
-- 1. Alimento (Va después de Vendedor)
-- ========
 
CREATE TABLE Alimento (
    IdAlimento INTEGER NOT NULL UNIQUE SERIAL, 
    IdPersona INTEGER NOT NULL, 
    FechaDeCaducidad DATE NOT NULL,
    Nombre VARCHAR(20) NOT NULL,
    Tipo VARCHAR(20) NOT NULL,
    Precio REAL NOT NULL CHECK (Precio > 0)
);

ALTER TABLE Alimento ADD CONSTRAINT pk_alimento PRIMARY KEY (IdAlimento);
ALTER TABLE Alimento ADD CONSTRAINT fk_alimento_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona);

-- ========
-- 2. EncargadoRegistro 
-- ========
 
CREATE TABLE EncargadoRegistro (
    IdPersona INTEGER NOT NULL UNIQUE SERIAL, 
    Nombre VARCHAR(20) NOT NULL,
    ApellidoMaterno VARCHAR(20) NOT NULL,
    ApellidoPaterno VARCHAR(20) NOT NULL,
    FechaDeNacimiento DATE NOT NULL,
    Sexo CHAR(10) NOT NULL CHECK (Sexo IN ('M', 'H', 'Otro')),
    Calle VARCHAR(20) NOT NULL,
    Colonia VARCHAR(20) NOT NULL,
    Ciudad VARCHAR(20) NOT NULL,
    CodigoPostal INTEGER NOT NULL, 
    NumInterior INTEGER NOT NULL, 
    NumExterior INTEGER NOT NULL, 
    EsJugador BOOLEAN NOT NULL
);

ALTER TABLE EncargadoRegistro ADD CONSTRAINT pk_encargado_registro PRIMARY KEY (IdPersona);

-- ======== 
-- 3. ComprarEncargadoRegistro (Va después de EncargadoRegistro y Alimento)
-- ========

CREATE TABLE ComprarEncargadoRegistro (
    IdPersona INTEGER NOT NULL, 
    IdAlimento INTEGER NOT NULL, 
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL NOT NULL CHECK (Cantidad > 0)
);

ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT fk_comprar_encargado_registro_encargado FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona);
ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT fk_comprar_encargado_registro_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);

-- ========
-- 4. CorreoEncargadoRegistro (Va después de EncargadoRegistro)
-- =======
CREATE TABLE CorreoEncargadoRegistro (
    IdPersona INTEGER NOT NULL,
    Correo VARCHAR(50) NOT NULL
);

ALTER TABLE CorreoEncargadoRegistro ADD CONSTRAINT pk_correo_encargado_registro PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoEncargadoRegistro ADD CONSTRAINT fk_correo_encargado_registro FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona);


-- ========
-- 5. TelefonoEncargadoRegistro (Va después de EncargadoRegistro)
-- =======
CREATE TABLE TelefonoEncargadoRegistro (
    IdPersona INTEGER NOT NULL,
    Telefono CHAR(10) NOT NULL
);
ALTER TABLE TelefonoEncargadoRegistro ADD CONSTRAINT pk_telefono_encargado_registro PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoEncargadoRegistro ADD CONSTRAINT fk_telefono_encargado_registro FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona);


-- ========
-- 6. EncargadoInscribirParticipante (Va después de EncargadoRegistro y ParticipanteUNAM)
-- =======

CREATE TABLE EncargadoInscribirParticipante (
    IdPersona_encargado INTEGER NOT NULL, 
    IdPersona_participante INTEGER NOT NULL, 
    Fecha DATE NOT NULL
);

ALTER TABLE TrabajarEncargadoRegistro ADD CONSTRAINT fk_trabajar_encargado_registro_evento FOREIGN KEY (edicion) REFERENCES Evento(edicion);
ALTER TABLE TrabajarEncargadoRegistro ADD CONSTRAINT fk_trabajar_encargado_registro_encargado FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona);


-- ========
-- 7. TrabajarEncargadoRegistro (Va después de EncargadoRegistro y Evento)
-- =======

CREATE TABLE TrabajarEncargadoRegistro (
    Edicion INTEGER NOT NULL, 
    IdPersona INTEGER NOT NULL
);

ALTER TABLE TrabajarEncargadoRegistro ADD CONSTRAINT fk_trabajar_encargado_registro_evento FOREIGN KEY (Edicion) REFERENCES Evento(edicion);
ALTER TABLE TrabajarEncargadoRegistro ADD CONSTRAINT fk_trabajar_encargado_registro_encargado FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona);


-- ========
-- 8. TrabajarCuidador (Va después de Cuidador y Evento)
-- =======

CREATE TABLE TrabajarCuidador (
    Edicion INTEGER NOT NULL, 
    IdPersona INTEGER NOT NULL
);

ALTER TABLE TrabajarCuidador ADD CONSTRAINT fk_trabajar_cuidador_evento FOREIGN KEY (Edicion) REFERENCES Evento(edicion);
ALTER TABLE TrabajarCuidador ADD CONSTRAINT fk_trabajar_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona);




--  XIMENA
-- ========
-- 1.Vendedor 
-- =======
CREATE TABLE Vendedor (
    IdPersona INTEGER NOT NULL, 
    Nombre VARCHAR(20) NOT NULL,
    ApellidoMaterno VARCHAR(20) NOT NULL,
    ApellidoPaterno VARCHAR(20) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo VARCHAR (10) NOT NULL CHECK (Sexo IN ('M', 'H', 'Otro')),
    Calle VARCHAR (20) NOT NULL,
    Colonia VARCHAR (20) NOT NULL,
    Ciudad VARCHAR (20) NOT NULL,
    CodigoPostal INTEGER NOT NULL,
    NumInterior INTEGER,
    NumExterior INTEGER NOT NULL,
    Ubicacion VARCHAR (20) 

);
ALTER TABLE Vendedor ADD CONSTRAINT pk_vendedor PRIMARY KEY (IdPersona);

-- ========
-- 2. ComprarVendedor 
-- =======
CREATE TABLE ComprarVendedor (
    IdPersona INTEGER NOT NULL,
    IdAlimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL NOT NULL CHECK (Cantidad > 0)
);
ALTER TABLE ComprarVendedor  ADD CONSTRAINT fk_comprar_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor (IdPersona);
ALTER TABLE ComprarVendedor ADD CONSTRAINT fk_comprar_vendedor_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);

-- ========
-- 3. CorreoVendedor 
-- =======
CREATE TABLE CorreoVendedor(
    IdPersona INTEGER NOT NULL,
    Correo VARCHAR(50) NOT NULL
);
ALTER TABLE CorreoVendedor ADD CONSTRAINT pk_correo_vendedor PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoVendedor ADD CONSTRAINT fk_correo_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona);

-- ========
-- 4. TelefonoVendedor 
-- =======
CREATE TABLE TelefonoVendedor(
    IdPersona INTEGER NOT NULL,
    Telefono CHAR(10) NOT NULL
);
ALTER TABLE TelefonoVendedor ADD CONSTRAINT pk_telefono_vendedor PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoVendedor ADD CONSTRAINT fk_telefono_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona);

-- ========
-- 5. TrabajarVendedor 
-- =======
CREATE TABLE TrabajarVendedor(
    Edicion INTEGER NOT NULL,
    IdPersona INTEGER NOT NULL
);
ALTER TABLE TrabajarLimpiador ADD CONSTRAINT fk_trabajar_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona);
ALTER TABLE TrabajarLimpiador ADD CONSTRAINT fk_trabajar_vendedor_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);

-- ========
-- 6. Cuidador
-- =======
CREATE TABLE Cuidador (
    IdPersona INTEGER NOT NULL,
    Nombre VARCHAR (20) NOT NULL,
    ApellidoMaterno VARCHAR (20) NOT NULL,
    ApellidoPaterno VARCHAR (20) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo VARCHAR (10) NOT NULL CHECK (Sexo IN ('M', 'H', 'Otro')),
    Calle VARCHAR (20) NOT NULL,
    Colonia VARCHAR (20) NOT NULL,
    Ciudad VARCHAR (20) NOT NULL,
    CodigoPostal INTEGER NOT NULL,
    NumInterior INTEGER ,
    NumExterior INTEGER NOT NULL,
    Ubicacion VARCHAR (20),
    Horario VARCHAR (10) CHECK (Horario IN ('Matutino', 'Vespertino')),
    Salario REAL  CHECK (Salario >= 0)
);
ALTER TABLE Cuidador ADD CONSTRAINT pk_cuidador PRIMARY KEY (IdPersona);

-- ========
-- 7. CorreoCuidador 
-- =======
CREATE TABLE CorreoCuidador (
    IdPersona INTEGER NOT NULL,
    Correo VARCHAR (50) NOT NULL
);
ALTER TABLE CorreoCuidador ADD CONSTRAINT pk_correo_cuidador PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoCuidador ADD CONSTRAINT fk_correo_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona);

-- ========
-- 8. TelefonoCuidador
-- =======
CREATE TABLE TelefonoCuidador(
    IdPersona INTEGER NOT NULL,
    Telefono CHAR(10) NOT NULL
);
ALTER TABLE TelefonoCuidador ADD CONSTRAINT pk_telefono_cuidador PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoCuidador ADD CONSTRAINT fk_telefono_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona);

-- LARA

-- ========
-- 1. ParticipanteUNAM
-- ========
CREATE TABLE ParticipanteUNAM (
    IdPersona INTEGER NOT NULL,
    NumeroDeCuenta INTEGER NOT NULL UNIQUE,
    Nombre VARCHAR(20) NOT NULL,
    ApellidoMaterno VARCHAR(20) NOT NULL,
    ApellidoPaterno VARCHAR(20) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo CHAR(10) CHECK (Sexo IN ('M', 'H', 'Otro')),
    Carrera VARCHAR(20) NOT NULL,
    Facultad VARCHAR(20) NOT NULL
);

ALTER TABLE ParticipanteUNAM 
ADD CONSTRAINT PK_ParticipanteUNAM PRIMARY KEY (IdPersona);


-- ========
-- 2. Espectador
-- ========
CREATE TABLE Espectador (
    IdPersona INTEGER NOT NULL,
    Nombre VARCHAR(20) NOT NULL,
    ApellidoMaterno VARCHAR(20) NOT NULL,
    ApellidoPaterno VARCHAR(20) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo CHAR(10) CHECK (Sexo IN ('M', 'H', 'Otro')),
    HoraIngreso TIMETZ,
    HoraSalida TIMETZ
);

ALTER TABLE Espectador 
ADD CONSTRAINT PK_Espectador PRIMARY KEY (IdPersona);


-- ========
-- 3. ComprarEspectador
-- ========
CREATE TABLE ComprarEspectador (
    IdPersona INTEGER NOT NULL,
    IdAlimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL
);

ALTER TABLE ComprarEspectador 
ADD CONSTRAINT PK_ComprarEspectador PRIMARY KEY (IdPersona, IdAlimento);

ALTER TABLE ComprarEspectador 
ADD CONSTRAINT FK_Espectador_Comprar FOREIGN KEY (IdPersona) REFERENCES Espectador(IdPersona);

ALTER TABLE ComprarEspectador 
ADD CONSTRAINT FK_Alimento_Comprar FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);


-- ========
-- 4. ComprarParticipanteUNAM
-- ========
CREATE TABLE ComprarParticipanteUNAM (
    IdPersona INTEGER NOT NULL,
    IdAlimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL
);

ALTER TABLE ComprarParticipanteUNAM 
ADD CONSTRAINT PK_ComprarParticipanteUNAM PRIMARY KEY (IdPersona, IdAlimento);

ALTER TABLE ComprarParticipanteUNAM 
ADD CONSTRAINT FK_Participante_Comprar FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

ALTER TABLE ComprarParticipanteUNAM 
ADD CONSTRAINT FK_Alimento_Comprar_Participante FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);


-- ========
-- 5. CorreoParticipante
-- ========
CREATE TABLE CorreoParticipante (
    IdPersona INTEGER NOT NULL,
    Correo VARCHAR(50) NOT NULL
);

ALTER TABLE CorreoParticipante 
ADD CONSTRAINT PK_CorreoParticipante PRIMARY KEY (IdPersona, Correo);

ALTER TABLE CorreoParticipante 
ADD CONSTRAINT FK_Participante_Correo FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);


-- ========
-- 6. ParticipanteInscribirEvento
-- ========
CREATE TABLE ParticipanteInscribirEvento (
    Edicion INTEGER NOT NULL,
    IdPersona INTEGER NOT NULL,
    Fecha DATE NOT NULL,
    Costo REAL NOT NULL
);

ALTER TABLE ParticipanteInscribirEvento 
ADD CONSTRAINT PK_ParticipanteInscribirEvento PRIMARY KEY (Edicion, IdPersona);

ALTER TABLE ParticipanteInscribirEvento 
ADD CONSTRAINT FK_InscribirEvento_Edicion FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);

ALTER TABLE ParticipanteInscribirEvento 
ADD CONSTRAINT FK_InscribirEvento_Participante FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);


-- ========
-- 7. Asistir
-- ========
CREATE TABLE Asistir (
    Edicion INTEGER NOT NULL,
    IdPersona INTEGER NOT NULL
);

ALTER TABLE Asistir 
ADD CONSTRAINT PK_Asistir PRIMARY KEY (Edicion, IdPersona);

ALTER TABLE Asistir 
ADD CONSTRAINT FK_Asistir_Edicion FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);

ALTER TABLE Asistir 
ADD CONSTRAINT FK_Asistir_Espectador FOREIGN KEY (IdPersona) REFERENCES Espectador(IdPersona);


-- ========
-- 8. TelefonoParticipante
-- ========
CREATE TABLE TelefonoParticipante (
    IdPersona INTEGER NOT NULL,
    Telefono CHAR(10) NOT NULL
);

ALTER TABLE TelefonoParticipante 
ADD CONSTRAINT PK_TelefonoParticipante PRIMARY KEY (IdPersona, Telefono);

ALTER TABLE TelefonoParticipante 
ADD CONSTRAINT FK_Telefono_Participante FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);