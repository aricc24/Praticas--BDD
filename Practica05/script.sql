
-- ========
-- Evento
-- =======
CREATE TABLE Evento (
    edicion INTEGER,
    fecha DATE
);

ALTER TABLE Evento ADD PRIMARY KEY (edicion);

-- ========
-- CuentaPokemon
-- =======

CREATE TABLE CuentaPokemon (
    id_persona INTEGER,
    codigo_de_entrenador INTEGER,
    equipo VARCHAR(20),
    nivel INTEGER,
    nombreDeUsuario VARCHAR(30),
);

ALTER TABLE CuentaPokemon ADD PRIMARY KEY (id_persona, codigo_de_entrenador);

ALTER TABLE CuentaPokemon ADD FOREIGN KEY (id_persona) 
    REFERENCES ParticipanteUNAM (id_persona);


-- ========
-- Pokemon
-- =======
CREATE TABLE Pokemon (
    id_pokemon INTEGER,
    nombre VARCHAR(50),
    sexo VARCHAR(10),
    peso REAL,
    puntosDeCombate INTEGER,
    shiny BOOLEAN,
    tipo VARCHAR(20),
    especie VARCHAR(20),
    id_persona INTEGER,
    codigo_de_entrenador INTEGER
);

ALTER TABLE Pokemon ADD PRIMARY KEY (id_pokemon);
ALTER TABLE Pokemon ADD FOREIGN KEY (id_persona, codigo_de_entrenador)
    REFERENCES CuentaPokemon (id_persona, codigo_de_entrenador);

-- ========
-- ComprarCuidador (Va después de Cuidador y Alimento)
-- ========
CREATE TABLE ComprarCuidador (
    id_persona INTEGER NOT NULL,
    id_alimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20),
    Cantidad REAL
);
ALTER TABLE ComprarCuidador ADD CONSTRAINT fk_comprar_cuidador_cuidador FOREIGN KEY (id_persona) REFERENCES Cuidador(id_persona);
ALTER TABLE ComprarCuidador ADD CONSTRAINT fk_comprar_cuidador_alimento FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento);

-- ========
-- Limpiador 
-- =======
CREATE TABLE Limpiador (
    id_persona INTEGER NOT NULL,
    Nombre VARCHAR(20),
    ApellidoMaterno VARCHAR(20),
    ApellidoPaterno VARCHAR(20),
    FechaNacimiento DATE,
    Sexo VARCHAR(10),
    Calle VARCHAR(20),
    Colonia VARCHAR(20),
    Ciudad VARCHAR(20),
    CodigoPostal INTEGER,
    NumInterior INTEGER,
    NumExterior INTEGER,
    Ubicacion VARCHAR(20),
    Horario TIMETZ,
    Salario REAL
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
    MetodoDePago VARCHAR(20),
    Cantidad REAL
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
    CantidadAPremiar REAL
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
    NumeroPelea INTEGER NOT NULL,
    id_persona INTEGER,
    CodigoDeEntrenador INTEGER,
    Fecha DATE,
    Fase INTEGER
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
    id_alimento INTEGER, 
    id_persona INTEGER, 
    FechaDeCaducidad DATE,
    Nombre VARCHAR(20),
    Tipo VARCHAR(20),
    Precio REAL
);

ALTER TABLE Alimento ADD CONSTRAINT pk_alimento PRIMARY KEY (id_alimento);
ALTER TABLE Alimento ADD CONSTRAINT fk_alimento_vendedor FOREIGN KEY (id_persona) REFERENCES Vendedor(id_persona);


-- ========
-- Encargado Regsitro 
-- ========
 
CREATE TABLE EncargadoRegistro (
    id_persona INTEGER, 
    Nombre VARCHAR(20),
    ApellidoMaterno VARCHAR(20),
    ApellidoPaterno VARCHAR(20),
    FechaDeNacimiento DATE,
    Sexo VARCHAR(10),
    Calle VARCHAR(20),
    Colonia VARCHAR(20),
    Ciudad VARCHAR(20),
    CodigoPostal INTEGER, 
    NumInterior INTEGER, 
    NumExterior INTEGER, 
    EsJugador BOOLEAN

);

ALTER TABLE EncargadoRegistro ADD CONSTRAINT pk_encargado_registro PRIMARY KEY (id_persona);


-- ======== 
-- ComprarEncargadoRegsitro (Va después de EncargadoRegistro y Alimento)
-- ========

CREATE TABLE ComprarEncargadoRegistro (
    id_persona INTEGER NOT NULL, 
    id_alimento INTEGER NOT NULL, 
    MetodoDePago VARCHAR(20),
    Cantidad REAL
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
    Fecha DATE
);

ALTER TABLE EncargadoInscribirParticipante ADD CONSTRAINT fk_encargado_inscribir_participante_encargado FOREIGN KEY (id_persona_encargado) REFERENCES EncargadoRegistro(id_persona);
ALTER TABLE EncargadoInscribirParticipante ADD CONSTRAINT fk_encargado_inscribir_participante_participante FOREIGN KEY (id_persona_participante) REFERENCES ParticipanteUNAM(id_persona);


-- ========
-- TrabajarEncargadoRegistro (Va después de EncargadoRegistro y Evento)
-- =======

CREATE TABLE TrabajarEncargadoRegistro (
    edicion INTEGER NOT NULL, 
    id_persona INTEGER NOT NULL
);

ALTER TABLE TrabajarEncargadoRegistro ADD CONSTRAINT fk_trabajar_encargado_registro_evento FOREIGN KEY (edicion) REFERENCES Evento(edicion);
ALTER TABLE TrabajarEncargadoRegistro ADD CONSTRAINT fk_trabajar_encargado_registro_encargado FOREIGN KEY (id_persona) REFERENCES EncargadoRegistro(id_persona);



-- ========
-- TrabajarEncargadoRegistro (Va después de Cuidador y Evento)
-- =======

CREATE TABLE TrabajarCuidador (
    edicion INTEGER NOT NULL, 
    id_persona INTEGER NOT NULL
);

ALTER TABLE TrabajarCuidador ADD CONSTRAINT fk_trabajar_cuidador_evento FOREIGN KEY (edicion) REFERENCES Evento(edicion);
ALTER TABLE TrabajarCuidador ADD CONSTRAINT fk_trabajar_cuidador_cuidador FOREIGN KEY (id_persona) REFERENCES Cuidador(id_persona);

