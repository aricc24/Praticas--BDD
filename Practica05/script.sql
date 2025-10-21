- ========
-- Evento 
-- =======
CREATE TABLE Evento (
    Edicion INTEGER NOT NULL UNIQUE,
    Fecha DATE NOT NULL
);

ALTER TABLE Evento ADD CONSTRAINT pk_evento PRIMARY KEY (Edicion);


-- ========
-- CuentaPokemon
-- =======

CREATE TABLE CuentaPokemonGo (
    id_persona INTEGER NOT NULL,
    CodigoDeEntrenador INTEGER NOT NULL UNIQUE SERIAL,
    Equipo VARCHAR(20) NOT NULL,
    Nivel SMALLINT NOT NULL CHECK (Nivel >= 1),
    NombreDeUsuario VARCHAR(30) NOT NULL UNIQUE
);


ALTER TABLE CuentaPokemonGo ADD CONSTRAINT pk_cuenta_pokemon_go PRIMARY KEY (id_persona, CodigoDeEntrenador);

ALTER TABLE CuentaPokemonGo ADD CONSTRAINT fk_cuenta_pokemon_go_participante_unam FOREIGN KEY (id_persona) REFERENCES ParticipanteUNAM(id_persona);

-- ========
-- Pokemon
-- =======
CREATE TABLE Pokemon (
    id_pokemon INTEGER NOT NULL UNIQUE SERIAL,
    id_persona INTEGER NOT NULL,
    CodigoDeEntrenador INTEGER NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Sexo CHAR(10) NOT NULL CHECK (Sexo IN ('M', 'H', 'Otro')),
    Peso REAL NOT NULL CHECK (Peso > 0),
    PuntosDeCombate INTEGER NOT NULL CHECK (PuntosDeCombate >= 0),
    Shiny BOOLEAN NOT NULL,
    Tipo VARCHAR(20) NOT NULL,
    Especie VARCHAR(20) NOT NULL
);

ALTER TABLE Pokemon ADD CONSTRAINT pk_pokemon PRIMARY KEY (id_pokemon);

ALTER TABLE Pokemon ADD CONSTRAINT fk_pokemon_cuenta_pokemon_go FOREIGN KEY (id_persona, CodigoDeEntrenador)
    REFERENCES CuentaPokemonGo (id_persona, CodigoDeEntrenador);

-- ========
-- TorneoCapturaShinys 
-- ========
CREATE TABLE TorneoCapturaShinys (
    Edicion INTEGER NOT NULL,
    id_torneo INTEGER NOT NULL UNIQUE SERIAL,
    id_persona INTEGER,
    CantidadAPremiar REAL DEFAULT 500.0
);
   
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT pk_torneo_captura_shinys PRIMARY KEY (Edicion, id_torneo);
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT fk_torneo_captura_shinys_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT fk_torneo_captura_shinys_participante_unam FOREIGN KEY (id_persona) REFERENCES ParticipanteUNAM(id_persona);

-- ========
-- TorneoDistanciaRecorrida
-- ========
CREATE TABLE TorneoDistanciaRecorrida (
    Edicion INTEGER NOT NULL,
    id_torneo INTEGER NOT NULL UNIQUE SERIAL,
    id_persona INTEGER,
    CantidadAPremiar REAL DEFAULT 500.0
);

ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT pk_torneo_distancia_recorrida PRIMARY KEY (Edicion, id_torneo);
ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT fk_torneo_distancia_recorrida_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);
ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT fk_torneo_distancia_recorrida_participante_unam FOREIGN KEY (id_persona) REFERENCES ParticipanteUNAM(id_persona);

-- ========
-- CapturaPokemon
-- ========
CREATE TABLE CapturaPokemon (
    Edicion INTEGER NOT NULL,
    id_torneo INTEGER NOT NULL,
    id_captura INTEGER NOT NULL UNIQUE SERIAL
);


ALTER TABLE CapturaPokemon ADD CONSTRAINT pk_captura_pokemon PRIMARY KEY (Edicion, id_torneo, id_captura);
ALTER TABLE CapturaPokemon ADD CONSTRAINT fk_captura_pokemon_torneo_captura_shinys FOREIGN KEY (Edicion, id_torneo) REFERENCES TorneoCapturaShinys(Edicion, id_torneo);

-- ========
-- Registrar
-- ========
CREATE TABLE Registrar (
    id_pokemon INTEGER NOT NULL,
    CodigoDeEntrenador INTEGER NOT NULL,
    id_persona INTEGER NOT NULL,
    id_captura INTEGER NOT NULL,
    Edicion INTEGER NOT NULL,
    id_torneo INTEGER NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIMETZ NOT NULL
);


ALTER TABLE Registrar ADD CONSTRAINT fk_registrar_cuenta_pokemon_go FOREIGN KEY (id_persona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(id_persona, CodigoDeEntrenador);
ALTER TABLE Registrar ADD CONSTRAINT fk_registrar_captura_pokemon FOREIGN KEY (Edicion, id_torneo, id_captura) REFERENCES CapturaPokemon(Edicion, id_torneo, id_captura);
ALTER TABLE Registrar ADD CONSTRAINT fk_registrar_pokemon FOREIGN KEY (id_pokemon) REFERENCES Pokemon(id_pokemon);

-- ========
-- DistanciaRecorrida
-- ========
CREATE TABLE DistanciaRecorrida (
    Edicion INTEGER NOT NULL,
    id_torneo INTEGER NOT NULL,
    id_distancia INTEGER NOT NULL UNIQUE SERIAL,
    id_persona INTEGER NOT NULL,
    CodigoDeEntrenador INTEGER NOT NULL,
    Locación VARCHAR(10) NOT NULL CHECK (Locación IN ('Universum', 'Entrada', 'Rectoria')),
    Fecha DATE NOT NULL,
    Hora TIMETZ NOT NULL
);

ALTER TABLE DistanciaRecorrida ADD CONSTRAINT pk_distancia_recorrido PRIMARY KEY (Edicion, id_torneo, id_distancia);
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT fk_distancia_recorrida_cuenta_pokemon_go FOREIGN KEY (id_persona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(id_persona, CodigoDeEntrenador);
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT fk_distancia_recorrida_torneo_distancia_recorrida FOREIGN KEY (Edicion, id_torneo) REFERENCES TorneoDistanciaRecorrida(Edicion, id_torneo);


-- ========
-- ComprarCuidador (Va después de Cuidador y Alimento)
-- ========
CREATE TABLE ComprarCuidador (
    id_persona INTEGER NOT NULL,
    id_alimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL NOT NULL CHECK (Cantidad > 0)
);
ALTER TABLE ComprarCuidador ADD CONSTRAINT fk_comprar_cuidador_cuidador FOREIGN KEY (id_persona) REFERENCES Cuidador(id_persona);
ALTER TABLE ComprarCuidador ADD CONSTRAINT fk_comprar_cuidador_alimento FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento);

-- ========
-- Limpiador 
-- =======
CREATE TABLE Limpiador (
    id_persona INTEGER NOT NULL SERIAL,
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
ALTER TABLE Limpiador ADD CONSTRAINT pk_limpiador PRIMARY KEY (id_persona);

-- ========
-- CorreoLimpiador (Va después de Limpiador)
-- =======
CREATE TABLE CorreoLimpiador (
    id_persona INTEGER NOT NULL,
    Correo VARCHAR(50) NOT NULL
);
ALTER TABLE CorreoLimpiador ADD CONSTRAINT pk_correo_limpiador PRIMARY KEY (id_persona, Correo);
ALTER TABLE CorreoLimpiador ADD CONSTRAINT fk_correo_limpiador_limpiador FOREIGN KEY (id_persona) REFERENCES Limpiador(id_persona);

-- ========
-- TelefonoLimpiador (Va después de Limpiador)
-- =======
CREATE TABLE TelefonoLimpiador (
    id_persona INTEGER NOT NULL,
    Telefono CHAR(10) NOT NULL
);
ALTER TABLE TelefonoLimpiador ADD CONSTRAINT pk_telefono_limpiador PRIMARY KEY (id_persona, Telefono);
ALTER TABLE TelefonoLimpiador ADD CONSTRAINT fk_telefono_limpiador_limpiador FOREIGN KEY (id_persona) REFERENCES Limpiador(id_persona);

-- ========
-- TrabajarLimpiador (Va después de Limpiador y Evento)
-- =======
CREATE TABLE TrabajarLimpiador (
    id_persona INTEGER NOT NULL,
    Edicion INTEGER NOT NULL
);
ALTER TABLE TrabajarLimpiador ADD CONSTRAINT fk_trabajar_limpiador_limpiador FOREIGN KEY (id_persona) REFERENCES Limpiador(id_persona);
ALTER TABLE TrabajarLimpiador ADD CONSTRAINT fk_trabajar_limpiador_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);

-- ========
-- ComprarLimpiador (Va después de Limpiador y Alimento) 
-- =======
CREATE TABLE ComprarLimpiador (
    id_persona INTEGER NOT NULL,
    id_alimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL NOT NULL CHECK (Cantidad > 0)
);
ALTER TABLE ComprarLimpiador ADD CONSTRAINT fk_comprar_limpiador_limpiador FOREIGN KEY (id_persona) REFERENCES Limpiador(id_persona);
ALTER TABLE ComprarLimpiador ADD CONSTRAINT fk_comprar_limpiador_alimento FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento);

-- ========
-- TorneoPelea (Va después de Evento y ParticipanteUNAM)
-- =======
CREATE TABLE TorneoPelea (
    Edicion INTEGER NOT NULL,
    id_torneo INTEGER NOT NULL,
    id_persona INTEGER,
    CantidadAPremiar REAL DEFAULT 500.0
);
ALTER TABLE TorneoPelea ADD CONSTRAINT pk_torneo_pelea PRIMARY KEY (Edicion, id_torneo);
ALTER TABLE TorneoPelea ADD CONSTRAINT fk_torneo_pelea_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);
ALTER TABLE TorneoPelea ADD CONSTRAINT fk_torneo_pelea_participante_unam FOREIGN KEY (id_persona) REFERENCES ParticipanteUNAM(id_persona);

-- ========
-- PeleaTorneo (Va después de TorneoPelea y CuentaPokemonGo)
-- =======
CREATE TABLE PeleaTorneo (
    Edicion INTEGER NOT NULL,
    id_torneo INTEGER NOT NULL,
    NumeroPelea INTEGER NOT NULL SERIAL,
    id_persona INTEGER,
    CodigoDeEntrenador INTEGER NOT NULL,
    Fecha DATE NOT NULL,
    Fase INTEGER NOT NULL
);
ALTER TABLE PeleaTorneo ADD CONSTRAINT pk_pelea_torneo PRIMARY KEY (Edicion, id_torneo, NumeroPelea);
ALTER TABLE PeleaTorneo ADD CONSTRAINT fk_pelea_torneo_torneo FOREIGN KEY (Edicion, id_torneo) REFERENCES TorneoPelea(Edicion, id_torneo);
ALTER TABLE PeleaTorneo ADD CONSTRAINT fk_pelea_torneo_cuenta_pokemon_go FOREIGN KEY (id_persona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(id_persona, CodigoDeEntrenador);

-- ========
-- Utilizar (Va después de PeleaTorneo y Pokemon)
-- ========
CREATE TABLE Utilizar (
    id_pokemon INTEGER NOT NULL,
    Edicion INTEGER NOT NULL,
    id_torneo INTEGER NOT NULL,
    NumeroPelea INTEGER NOT NULL,
);
ALTER TABLE Utilizar ADD CONSTRAINT fk_utilizar_pokemon FOREIGN KEY (id_pokemon) REFERENCES Pokemon(id_pokemon);
ALTER TABLE Utilizar ADD CONSTRAINT fk_utilizar_pelea_torneo FOREIGN KEY (Edicion, id_torneo, NumeroPelea) REFERENCES PeleaTorneo(Edicion, id_torneo, NumeroPelea);


-- ========
-- Alimento (Va después de Vendedor)
-- ========
 
CREATE TABLE Alimento (
    id_alimento INTEGER NOT NULL UNIQUE SERIAL, 
    id_persona INTEGER NOT NULL, 
    FechaDeCaducidad DATE NOT NULL,
    Nombre VARCHAR(20) NOT NULL,
    Tipo VARCHAR(20) NOT NULL,
    Precio REAL NOT NULL CHECK (Precio > 0)
);

ALTER TABLE Alimento ADD CONSTRAINT pk_alimento PRIMARY KEY (id_alimento);
ALTER TABLE Alimento ADD CONSTRAINT fk_alimento_vendedor FOREIGN KEY (id_persona) REFERENCES Vendedor(id_persona);

-- ========
-- EncargadoRegistro 
-- ========
 
CREATE TABLE EncargadoRegistro (
    id_persona INTEGER NOT NULL UNIQUE SERIAL, 
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

ALTER TABLE EncargadoRegistro ADD CONSTRAINT pk_encargado_registro PRIMARY KEY (id_persona);

-- ======== 
-- ComprarEncargadoRegistro (Va después de EncargadoRegistro y Alimento)
-- ========

CREATE TABLE ComprarEncargadoRegistro (
    id_persona INTEGER NOT NULL, 
    id_alimento INTEGER NOT NULL, 
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL NOT NULL CHECK (Cantidad > 0)
);

ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT fk_comprar_encargado_registro_encargado FOREIGN KEY (id_persona) REFERENCES EncargadoRegistro(id_persona);
ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT fk_comprar_encargado_registro_alimento FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento);

-- ========
-- CorreoEncargadoRegistro (Va después de EncargadoRegistro)
-- =======
CREATE TABLE CorreoEncargadoRegistro (
    id_persona INTEGER NOT NULL,
    Correo VARCHAR(50) NOT NULL
);

ALTER TABLE CorreoEncargadoRegistro ADD CONSTRAINT pk_correo_encargado_registro PRIMARY KEY (id_persona, Correo);
ALTER TABLE CorreoEncargadoRegistro ADD CONSTRAINT fk_correo_encargado_registro FOREIGN KEY (id_persona) REFERENCES EncargadoRegistro(id_persona);


-- ========
-- TelefonoEncragadoResgitro (Va después de EncargadoRegistro)
-- =======
CREATE TABLE TelefonoEncragadoResgitro (
    id_persona INTEGER NOT NULL,
    Telefono CHAR(10) NOT NULL
);
ALTER TABLE TelefonoEncragadoResgitro ADD CONSTRAINT pk_telefono_encargado_registro PRIMARY KEY (id_persona, Telefono);
ALTER TABLE TelefonoEncragadoResgitro ADD CONSTRAINT fk_telefono_encargado_registro FOREIGN KEY (id_persona) REFERENCES EncargadoRegistro(id_persona);


-- ========
-- EncargadoInscribirParticipante (Va después de EncargadoRegistro y ParticipanteUNAM)
-- =======

CREATE TABLE EncargadoInscribirParticipante (
    id_persona_encargado INTEGER NOT NULL, 
    id_persona_participante INTEGER NOT NULL, 
    Fecha DATE NOT NULL
);

ALTER TABLE TrabajarEncargadoRegistro ADD CONSTRAINT fk_trabajar_encargado_registro_evento FOREIGN KEY (edicion) REFERENCES Evento(edicion);
ALTER TABLE TrabajarEncargadoRegistro ADD CONSTRAINT fk_trabajar_encargado_registro_encargado FOREIGN KEY (id_persona) REFERENCES EncargadoRegistro(id_persona);


-- ========
-- TrabajarEncargadoRegistro (Va después de EncargadoRegistro y Evento)
-- =======

CREATE TABLE TrabajarEncargadoRegistro (
    Edicion INTEGER NOT NULL, 
    id_persona INTEGER NOT NULL
);

ALTER TABLE TrabajarEncargadoRegistro ADD CONSTRAINT fk_trabajar_encargado_registro_evento FOREIGN KEY (Edicion) REFERENCES Evento(edicion);
ALTER TABLE TrabajarEncargadoRegistro ADD CONSTRAINT fk_trabajar_encargado_registro_encargado FOREIGN KEY (id_persona) REFERENCES EncargadoRegistro(id_persona);


-- ========
-- TrabajarCuidador (Va después de Cuidador y Evento)
-- =======

CREATE TABLE TrabajarCuidador (
    Edicion INTEGER NOT NULL, 
    id_persona INTEGER NOT NULL
);

ALTER TABLE TrabajarCuidador ADD CONSTRAINT fk_trabajar_cuidador_evento FOREIGN KEY (Edicion) REFERENCES Evento(edicion);
ALTER TABLE TrabajarCuidador ADD CONSTRAINT fk_trabajar_cuidador_cuidador FOREIGN KEY (id_persona) REFERENCES Cuidador(id_persona);