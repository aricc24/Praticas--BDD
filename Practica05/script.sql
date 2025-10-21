-- ========
--  Evento 
-- =======
CREATE TABLE Evento (
    Edicion INTEGER,
    Fecha DATE
);
ALTER TABLE Evento ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE Evento ADD CONSTRAINT uq_evento_edicion UNIQUE (Edicion);
ALTER TABLE Evento ALTER COLUMN Fecha SET NOT NULL;
ALTER TABLE Evento ADD CONSTRAINT pk_evento PRIMARY KEY (Edicion);

------------------- PERSONAS -------------------
-- ========
--  ParticipanteUNAM
-- ========
CREATE TABLE ParticipanteUNAM (
    IdPersona INTEGER,
    NumeroDeCuenta INTEGER,
    Nombre VARCHAR(20),
    ApellidoMaterno VARCHAR(20),
    ApellidoPaterno VARCHAR(20)
    FechaNacimiento DATE,
    Sexo VARCHAR(10),
    Carrera VARCHAR(20),
    Facultad VARCHAR(20)
);
ALTER TABLE ParticipanteUNAM ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ParticipanteUNAM ADD CONSTRAINT uq_participante_unam_idpersona UNIQUE (IdPersona);
ALTER TABLE ParticipanteUNAM ALTER COLUMN NumeroDeCuenta SET NOT NULL;
ALTER TABLE ParticipanteUNAM ADD CONSTRAINT uq_participante_unam_numerodecuenta UNIQUE (NumeroDeCuenta);
ALTER TABLE ParticipanteUNAM ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE ParticipanteUNAM ALTER COLUMN ApellidoMaterno SET NOT NULL;
ALTER TABLE ParticipanteUNAM ALTER COLUMN ApellidoPaterno SET NOT NULL;
ALTER TABLE ParticipanteUNAM ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE ParticipanteUNAM ADD CONSTRAINT chk_participante_unam_sexo CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE ParticipanteUNAM ALTER COLUMN Carrera SET NOT NULL;
ALTER TABLE ParticipanteUNAM ALTER COLUMN Facultad SET NOT NULL;
ALTER TABLE ParticipanteUNAM ADD CONSTRAINT pk_ParticipanteUNAM PRIMARY KEY (IdPersona);

-- ========
-- EncargadoRegistro 
-- ========
CREATE TABLE EncargadoRegistro (
    IdPersona INTEGER,
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
ALTER TABLE EncargadoRegistro ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE EncargadoRegistro ADD CONSTRAINT uq_encargado_registro_idpersona UNIQUE (IdPersona);
ALTER TABLE EncargadoRegistro ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN ApellidoMaterno SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN ApellidoPaterno SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN FechaDeNacimiento SET NOT NULL;
ALTER TABLE EncargadoRegistro ADD CONSTRAINT chk_encargado_registro_sexo CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE EncargadoRegistro ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN Colonia SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN Ciudad SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN CodigoPostal SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN NumExterior SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN EsJugador SET NOT NULL;
ALTER TABLE EncargadoRegistro ADD CONSTRAINT pk_encargado_registro PRIMARY KEY (IdPersona);

-- ========
-- Vendedor 
-- =======
CREATE TABLE Vendedor (
    IdPersona INTEGER,
    Nombre VARCHAR(20),
    ApellidoMaterno VARCHAR(20),
    ApellidoPaterno VARCHAR(20),
    FechaNacimiento DATE,
    Sexo VARCHAR (10),
    Calle VARCHAR (20),
    Colonia VARCHAR (20),
    Ciudad VARCHAR (20),
    CodigoPostal INTEGER,
    NumInterior INTEGER,
    NumExterior INTEGER,
    Ubicacion VARCHAR (20) 
);
ALTER TABLE Vendedor ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Vendedor ADD CONSTRAINT uq_vendedor_idpersona UNIQUE (IdPersona);
ALTER TABLE Vendedor ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN ApellidoMaterno SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN ApellidoPaterno SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE Vendedor ADD CONSTRAINT chk_vendedor_sexo CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE Vendedor ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN Colonia SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN Ciudad SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN CodigoPostal SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN NumExterior SET NOT NULL
ALTER TABLE Vendedor ADD CONSTRAINT pk_vendedor PRIMARY KEY (IdPersona);


-- ========
-- Cuidador
-- =======
CREATE TABLE Cuidador (
    IdPersona INTEGER,
    Nombre VARCHAR (20),
    ApellidoMaterno VARCHAR (20),
    ApellidoPaterno VARCHAR (20),
    FechaNacimiento DATE,
    Sexo VARCHAR (10),
    Calle VARCHAR (20),
    Colonia VARCHAR (20),
    Ciudad VARCHAR (20),
    CodigoPostal INTEGER,
    NumInterior INTEGER ,
    NumExterior INTEGER,
    Ubicacion VARCHAR (20),
    Horario VARCHAR (10) ,
    Salario REAL 
);
ALTER TABLE Cuidador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT uq_cuidador_idpersona UNIQUE (IdPersona);
ALTER TABLE Cuidador ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN ApellidoMaterno SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN ApellidoPaterno SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT chk_cuidador_sexo CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE Cuidador ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN Colonia SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN Ciudad SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN CodigoPostal SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN NumExterior SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT chk_cuidador_horario CHECK (Horario IN ('Matutino', 'Vespertino'));
ALTER TABLE Cuidador ALTER COLUMN Salario SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT chk_cuidador_salario CHECK (Salario >= 0);
ALTER TABLE Cuidador ADD CONSTRAINT pk_cuidador PRIMARY KEY (IdPersona);

-- ========
-- Limpiador 
-- =======
CREATE TABLE Limpiador (
    IdPersona INTEGER,
    Nombre VARCHAR(20),
    ApellidoMaterno VARCHAR(20),
    ApellidoPaterno VARCHAR(20),
    FechaNacimiento DATE ,
    Sexo VARCHAR(10) ,
    Calle VARCHAR(20) ,
    Colonia VARCHAR(20) ,
    Ciudad VARCHAR(20) ,
    CodigoPostal INTEGER ,
    NumInterior INTEGER,
    NumExterior INTEGER ,
    Ubicacion VARCHAR(20),
    Horario VARCHAR(10) ,
    Salario REAL
);
ALTER TABLE Limpiador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Limpiador ADD CONSTRAINT uq_limpiador_idpersona UNIQUE (IdPersona);
ALTER TABLE Limpiador ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN ApellidoMaterno SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN ApellidoPaterno SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE Limpiador ADD CONSTRAINT chk_limpiador_sexo CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE Limpiador ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN Colonia SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN Ciudad SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN CodigoPostal SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN NumExterior SET NOT NULL;
ALTER TABLE Limpiador ADD CONSTRAINT chk_limpiador_horario CHECK (Horario IN ('Matutino', 'Vespertino'));
ALTER TABLE Limpiador ADD CONSTRAINT chk_limpiador_salario CHECK (Salario >= 0);
ALTER TABLE Limpiador ADD CONSTRAINT pk_limpiador PRIMARY KEY (IdPersona);

-- ========
-- Espectador
-- ========
CREATE TABLE Espectador (
    IdPersona INTEGER,
    Nombre VARCHAR(20),
    ApellidoMaterno VARCHAR(20),
    ApellidoPaterno VARCHAR(20),
    FechaNacimiento DATE,
    Sexo VARCHAR(10),
    HoraIngreso TIMETZ,
    HoraSalida TIMETZ,
);
ALTER TABLE Espectador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Espectador ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Espectador ALTER COLUMN ApellidoMaterno SET NOT NULL;
ALTER TABLE Espectador ALTER COLUMN ApellidoPaterno SET NOT NULL;
ALTER TABLE Espectador ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE Espectador ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE Espectador ADD CONSTRAINT chk_espectador_sexo CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE Espectador ADD CONSTRAINT chk_espectador_horas CHECK (HoraSalida >= HoraIngreso);
ALTER TABLE Espectador ADD CONSTRAINT pk_Espectador PRIMARY KEY (IdPersona);

-- DATOS -------------------------------------
-- ========
-- 7. CorreoCuidador 
-- =======
CREATE TABLE CorreoCuidador (
    IdPersona INTEGER,
    Correo VARCHAR (50)
);
ALTER TABLE CorreoCuidador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE CorreoCuidador ALTER COLUMN Correo SET NOT NULL
ALTER TABLE CorreoCuidador ADD CONSTRAINT pk_correo_cuidador PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoCuidador ADD CONSTRAINT fk_correo_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona);

-- ========
-- 8. TelefonoCuidador
-- =======
CREATE TABLE TelefonoCuidador(
    IdPersona INTEGER,
    Telefono CHAR(10)
);
ALTER TABLE TelefonoCuidador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE TelefonoCuidador ALTER COLUMN Telefono SET NOT NULL;
ALTER TABLE TelefonoCuidador ADD CONSTRAINT pk_telefono_cuidador PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoCuidador ADD CONSTRAINT fk_telefono_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona);

-- ========
-- 4. CorreoEncargadoRegistro (Va después de EncargadoRegistro)
-- =======
CREATE TABLE CorreoEncargadoRegistro (
    IdPersona INTEGER,
    Correo VARCHAR(50)
);
ALTER TABLE CorreoEncargadoRegistro ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE CorreoEncargadoRegistro ALTER COLUMN Correo SET NOT NULL;
ALTER TABLE CorreoEncargadoRegistro ADD CONSTRAINT pk_correo_encargado_registro PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoEncargadoRegistro ADD CONSTRAINT fk_correo_encargado_registro FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona);

-- ========
-- 5. TelefonoEncargadoRegistro (Va después de EncargadoRegistro)
-- =======
CREATE TABLE TelefonoEncargadoRegistro (
    IdPersona INTEGER,
    Telefono CHAR(10)
);
ALTER TABLE TelefonoEncargadoRegistro ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE TelefonoEncargadoRegistro ALTER COLUMN Telefono SET NOT NULL;
ALTER TABLE TelefonoEncargadoRegistro ADD CONSTRAINT pk_telefono_encargado_registro PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoEncargadoRegistro ADD CONSTRAINT fk_telefono_encargado_registro FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona);

-- ========
-- 3. CorreoLimpiador (Va después de Limpiador)
-- =======
CREATE TABLE CorreoLimpiador (
    IdPersona INTEGER ,
    Correo VARCHAR(50)
);
ALTER TABLE CorreoLimpiador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE CorreoLimpiador ALTER COLUMN Correo SET NOT NULL
ALTER TABLE CorreoLimpiador ADD CONSTRAINT pk_correo_limpiador PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoLimpiador ADD CONSTRAINT fk_correo_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona);

-- ========
-- 4. TelefonoLimpiador (Va después de Limpiador)
-- =======
CREATE TABLE TelefonoLimpiador (
    IdPersona INTEGER ,
    Telefono CHAR(10) 
);
ALTER TABLE TelefonoLimpiador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE TelefonoLimpiador ALTER COLUMN Telefono SET NOT NULL;
ALTER TABLE TelefonoLimpiador ADD CONSTRAINT pk_telefono_limpiador PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoLimpiador ADD CONSTRAINT fk_telefono_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona);

-- ========
-- 3. CorreoVendedor 
-- =======
CREATE TABLE CorreoVendedor(
    IdPersona INTEGER,
    Correo VARCHAR(50)
);
ALTER TABLE CorreoVendedor ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE CorreoVendedor ALTER COLUMN Correo SET NOT NULL;
ALTER TABLE CorreoVendedor ADD CONSTRAINT pk_correo_vendedor PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoVendedor ADD CONSTRAINT fk_correo_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona);

-- ========
-- 4. TelefonoVendedor 
-- =======
CREATE TABLE TelefonoVendedor(
    IdPersona INTEGER,
    Telefono CHAR(10)
);
ALTER TABLE TelefonoVendedor ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE TelefonoVendedor ALTER COLUMN Telefono SET NOT NULL;
ALTER TABLE TelefonoVendedor ADD CONSTRAINT pk_telefono_vendedor PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoVendedor ADD CONSTRAINT fk_telefono_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona);

-- ========
-- 5. CorreoParticipante
-- ========
CREATE TABLE CorreoParticipante (
    IdPersona INTEGER,
    Correo VARCHAR(50)
);
ALTER TABLE CorreoParticipante ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE CorreoParticipante ALTER COLUMN Correo SET NOT NULL
ALTER TABLE CorreoParticipante ADD CONSTRAINT pk_CorreoParticipante PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoParticipante ADD CONSTRAINT fk_Participante_Correo FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

-- ========
-- 8. TelefonoParticipante
-- ========
CREATE TABLE TelefonoParticipante (
    IdPersona INTEGER,
    Telefono CHAR(10)
);
ALTER TABLE TelefonoParticipante ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE TelefonoParticipante ALTER COLUMN Telefono SET NOT NULL
ALTER TABLE TelefonoParticipante ADD CONSTRAINT pk_TelefonoParticipante PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoParticipante ADD CONSTRAINT fk_Telefono_Participante FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

---- TRABAJAR -------------------------------------------------
-- ========
-- TrabajarVendedor 
-- =======
CREATE TABLE TrabajarVendedor(
    Edicion INTEGER,
    IdPersona INTEGER
);
ALTER TABLE TrabajarVendedor ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE TrabajarVendedor ALTER COLUMN IdPersona SET NOT NULL
ALTER TABLE TrabajarVendedor ADD CONSTRAINT fk_trabajar_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona);
ALTER TABLE TrabajarVendedor ADD CONSTRAINT fk_trabajar_vendedor_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);

-- ========
-- TrabajarCuidador 
-- =======
CREATE TABLE TrabajarCuidador (
    Edicion INTEGER, 
    IdPersona INTEGER 
);
ALTER TABLE TrabajarCuidador ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE TrabajarCuidador ALTER COLUMN IdPersona SET NOT NULL
ALTER TABLE TrabajarCuidador ADD CONSTRAINT fk_trabajar_cuidador_evento FOREIGN KEY (Edicion) REFERENCES Evento(edicion);
ALTER TABLE TrabajarCuidador ADD CONSTRAINT fk_trabajar_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona);

-- ========
--  TrabajarLimpiador
-- =======
CREATE TABLE TrabajarLimpiador (
    IdPersona INTEGER,
    Edicion INTEGER
);
ALTER TABLE TrabajarLimpiador ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE TrabajarLimpiador ALTER COLUMN IdPersona SET NOT NULL
ALTER TABLE TrabajarLimpiador ADD CONSTRAINT fk_trabajar_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona);
ALTER TABLE TrabajarLimpiador ADD CONSTRAINT fk_trabajar_limpiador_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);

-- ========
-- TrabajarEncargadoRegistro 
-- =======
CREATE TABLE TrabajarEncargadoRegistro (
    Edicion INTEGER, 
    IdPersona INTEGER
);
ALTER TABLE TrabajarEncargadoRegistro ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE TrabajarEncargadoRegistro ALTER COLUMN IdPersona SET NOT NULL
ALTER TABLE TrabajarEncargadoRegistro ADD CONSTRAINT fk_trabajar_encargado_registro_evento FOREIGN KEY (Edicion) REFERENCES Evento(edicion);
ALTER TABLE TrabajarEncargadoRegistro ADD CONSTRAINT fk_trabajar_encargado_registro_encargado FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona);

--- COMPRAS---------------------------------------------
-- ========
-- Alimento (Va después de Vendedor)
-- ========
CREATE TABLE Alimento (
    IdAlimento INTEGER,
    IdPersona INTEGER, 
    FechaDeCaducidad DATE,
    Nombre VARCHAR(20),
    Tipo VARCHAR(20),
    Precio REAL
);
ALTER TABLE Alimento ALTER COLUMN IdAlimento SET NOT NULL;
ALTER TABLE Alimento ADD CONSTRAINT uq_alimento_idalimento UNIQUE (IdAlimento);
ALTER TABLE Alimento ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Alimento ALTER COLUMN FechaDeCaducidad SET NOT NULL;
ALTER TABLE Alimento ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Alimento ALTER COLUMN Tipo SET NOT NULL;
ALTER TABLE Alimento ALTER COLUMN Precio SET NOT NULL;
ALTER TABLE Alimento ADD CONSTRAINT chk_alimento_precio CHECK (Precio >= 0);
ALTER TABLE Alimento ADD CONSTRAINT pk_alimento PRIMARY KEY (IdAlimento);
ALTER TABLE Alimento ADD CONSTRAINT fk_alimento_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona);

-- ======== 
-- ComprarEncargadoRegistro 
-- ========
CREATE TABLE ComprarEncargadoRegistro (
    IdPersona INTEGER, 
    IdAlimento INTEGER, 
    MetodoDePago VARCHAR(20),
    Cantidad REAL 
);
ALTER TABLE ComprarEncargadoRegistro ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ComprarEncargadoRegistro ALTER COLUMN IdAlimento SET NOT NULL;
ALTER TABLE ComprarEncargadoRegistro ALTER COLUMN MetodoDePago SET NOT NULL;
ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT chk_comprar_encargado_registro_metodopago CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia'));
ALTER TABLE ComprarEncargadoRegistro ALTER COLUMN Cantidad SET NOT NULL;
ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT chk_comprar_encargado_registro_cantidad CHECK (Cantidad > 0);
ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT fk_comprar_encargado_registro_encargado FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona);
ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT fk_comprar_encargado_registro_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);

-- ========
-- ComprarLimpiador  
-- =======
CREATE TABLE ComprarLimpiador (
    IdPersona INTEGER,
    IdAlimento INTEGER,
    MetodoDePago VARCHAR(20),
    Cantidad REAL
);
ALTER TABLE ComprarLimpiador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ComprarLimpiador ALTER COLUMN IdAlimento SET NOT NULL;
ALTER TABLE ComprarLimpiador ALTER COLUMN MetodoDePago SET NOT NULL;
ALTER TABLE ComprarLimpiador ADD CONSTRAINT chk_comprar_limpiador_metodopago CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia'));
ALTER TABLE ComprarLimpiador ALTER COLUMN Cantidad SET NOT NULL;
ALTER TABLE ComprarLimpiador ADD CONSTRAINT chk_comprar_limpiador_cantidad CHECK (Cantidad > 0);
ALTER TABLE ComprarLimpiador ADD CONSTRAINT fk_comprar_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona);
ALTER TABLE ComprarLimpiador ADD CONSTRAINT fk_comprar_limpiador_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);

-- ========
-- ComprarCuidador 
-- ========
CREATE TABLE ComprarCuidador (
    IdPersona INTEGER,
    IdAlimento INTEGER,
    MetodoDePago VARCHAR(20),
    Cantidad REAL
);
ALTER TABLE ComprarCuidador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ComprarCuidador ALTER COLUMN IdAlimento SET NOT NULL;
ALTER TABLE ComprarCuidador ALTER COLUMN MetodoDePago SET NOT NULL;
ALTER TABLE ComprarCuidador ADD CONSTRAINT chk_comprar_cuidador_metodopago CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia'));
ALTER TABLE ComprarCuidador ALTER COLUMN Cantidad SET NOT NULL;
ALTER TABLE ComprarCuidador ADD CONSTRAINT chk_comprar_cuidador_cantidad CHECK (Cantidad > 0);
ALTER TABLE ComprarCuidador ADD CONSTRAINT fk_comprar_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona);
ALTER TABLE ComprarCuidador ADD CONSTRAINT fk_comprar_cuidador_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);

-- ========
-- ComprarVendedor 
-- =======
CREATE TABLE ComprarVendedor (
    IdPersona INTEGER,
    IdAlimento INTEGER,
    MetodoDePago VARCHAR(20),
    Cantidad REAL
);
ALTER TABLE ComprarVendedor ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ComprarVendedor ALTER COLUMN IdAlimento SET NOT NULL;
ALTER TABLE ComprarVendedor ALTER COLUMN MetodoDePago SET NOT NULL;
ALTER TABLE ComprarVendedor ADD CONSTRAINT chk_comprar_vendedor_metodopago CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia'));
ALTER TABLE ComprarVendedor ALTER COLUMN Cantidad SET NOT NULL;
ALTER TABLE ComprarVendedor ADD CONSTRAINT chk_comprar_vendedor_cantidad CHECK (Cantidad > 0);
ALTER TABLE ComprarVendedor  ADD CONSTRAINT fk_comprar_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor (IdPersona);
ALTER TABLE ComprarVendedor ADD CONSTRAINT fk_comprar_vendedor_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);

-- ========
-- ComprarEspectador
-- ========
CREATE TABLE ComprarEspectador (
    IdPersona INTEGER,
    IdAlimento INTEGER,
    MetodoDePago VARCHAR(20),
    Cantidad REAL
);
ALTER TABLE ComprarEspectador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ComprarEspectador ALTER COLUMN IdAlimento SET NOT NULL;
ALTER TABLE ComprarEspectador ALTER COLUMN MetodoDePago SET NOT NULL;
ALTER TABLE ComprarEspectador ADD CONSTRAINT chk_comprar_espectador_metodopago CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia'));
ALTER TABLE ComprarEspectador ALTER COLUMN Cantidad SET NOT NULL;
ALTER TABLE ComprarEspectador ADD CONSTRAINT chk_comprar_espectador_cantidad CHECK (Cantidad > 0);
ALTER TABLE ComprarEspectador ADD CONSTRAINT fk_Espectador_Comprar FOREIGN KEY (IdPersona) REFERENCES Espectador(IdPersona);
ALTER TABLE ComprarEspectador ADD CONSTRAINT fk_Alimento_Comprar FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);

-- ========
-- ComprarParticipanteUNAM
-- ========
CREATE TABLE ComprarParticipanteUNAM (
    IdPersona INTEGER NOT NULL,
    IdAlimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL CHECK (Cantidad > 0)
);

ALTER TABLE ComprarParticipanteUNAM 
ADD CONSTRAINT fk_Participante_Comprar FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

ALTER TABLE ComprarParticipanteUNAM 
ADD CONSTRAINT fk_Alimento_Comprar_Participante FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);



-----------Relaciones extra --------------------------------

-- ========
-- EncargadoInscribirParticipante 
-- =======

CREATE TABLE EncargadoInscribirParticipante (
    IdPersona_encargado INTEGER,
    IdPersona_participante INTEGER,
    Fecha DATE
);

ALTER TABLE EncargadoInscribirParticipante
ALTER COLUMN IdPersona_encargado SET NOT NULL,
ALTER COLUMN IdPersona_participante SET NOT NULL,
ALTER COLUMN Fecha SET NOT NULL,

-- ========
-- ParticipanteInscribirEvento
-- ========
CREATE TABLE ParticipanteInscribirEvento (
    Edicion INTEGER,
    IdPersona INTEGER,
    Fecha DATE,
    Costo REAL
);

ALTER TABLE ParticipanteInscribirEvento ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE ParticipanteInscribirEvento ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ParticipanteInscribirEvento ALTER COLUMN Fecha SET NOT NULL;
ALTER TABLE ParticipanteInscribirEvento ALTER COLUMN Costo SET NOT NULL;

ALTER TABLE ParticipanteInscribirEvento 
ADD CONSTRAINT pk_ParticipanteInscribirEvento PRIMARY KEY (Edicion, IdPersona);

ALTER TABLE ParticipanteInscribirEvento 
ADD CONSTRAINT fk_InscribirEvento_Edicion FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);

ALTER TABLE ParticipanteInscribirEvento 
ADD CONSTRAINT fk_InscribirEvento_Participante FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);


-- ========
-- Asistir
-- ========
CREATE TABLE Asistir (
    Edicion INTEGER,
    IdPersona INTEGER
);

ALTER TABLE Asistir ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE Asistir ALTER COLUMN IdPersona SET NOT NULL;

ALTER TABLE Asistir 
ADD CONSTRAINT pk_Asistir PRIMARY KEY (Edicion, IdPersona);

ALTER TABLE Asistir 
ADD CONSTRAINT fk_Asistir_Edicion FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);

ALTER TABLE Asistir 
ADD CONSTRAINT fk_Asistir_Espectador FOREIGN KEY (IdPersona) REFERENCES Espectador(IdPersona);




--------------- JUEGO 

-- ========
-- CuentaPokemon
-- =======

CREATE TABLE CuentaPokemonGo (
    IdPersona INTEGER,
    CodigoDeEntrenador INTEGER,
    Equipo VARCHAR(20),
    Nivel SMALLINT,
    NombreDeUsuario VARCHAR(30)
);


ALTER TABLE CuentaPokemonGo ADD CONSTRAINT pk_cuenta_pokemon_go PRIMARY KEY (IdPersona, CodigoDeEntrenador);
ALTER TABLE CuentaPokemonGo ADD CONSTRAINT fk_cuenta_pokemon_go_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);
ALTER TABLE CuentaPokemonGo ADD CONSTRAINT chk_nivel CHECK (Nivel >= 1);
ALTER TABLE CuentaPokemonGo ADD CONSTRAINT chk_equipo CHECK (Equipo IN ('Valor', 'Sabiduria', 'Instinto'));
ALTER TABLE CuentaPokemonGo ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE CuentaPokemonGo ALTER COLUMN CodigoDeEntrenador SET NOT NULL;
ALTER TABLE CuentaPokemonGo ALTER COLUMN Equipo SET NOT NULL;
ALTER TABLE CuentaPokemonGo ALTER COLUMN Nivel SET NOT NULL;
ALTER TABLE CuentaPokemonGo ALTER COLUMN NombreDeUsuario SET NOT NULL;
ALTER TABLE CuentaPokemonGo ADD CONSTRAINT uq_nombre_de_usuario UNIQUE (NombreDeUsuario);
ALTER TABLE CuentaPokemonGo ADD CONSTRAINT uq_persona_codigo_entrenador UNIQUE (IdPersona, CodigoDeEntrenador);

-- ========
-- Pokemon
-- =======
CREATE TABLE Pokemon (
    IdPokemon INTEGER ,
    IdPersona INTEGER ,
    CodigoDeEntrenador INTEGER ,
    Nombre VARCHAR(50) ,
    Sexo VARCHAR(10) ,
    Peso REAL CHECK (Peso > 0),
    PuntosDeCombate INTEGER CHECK (PuntosDeCombate >= 0),
    Shiny BOOLEAN ,
    Tipo VARCHAR(20) ,
    Especie VARCHAR(20) 
);

ALTER TABLE Pokemon ADD CONSTRAINT pk_pokemon PRIMARY KEY (IdPokemon);
ALTER TABLE Pokemon ADD CONSTRAINT fk_pokemon_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo (IdPersona, CodigoDeEntrenador);
ALTER TABLE Pokemon ALTER COLUMN IdPokemon SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN CodigoDeEntrenador SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN Peso SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN PuntosDeCombate SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN Shiny SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN Tipo SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN Especie SET NOT NULL;
ALTER TABLE Pokemon ADD CONSTRAINT uq_pokemon UNIQUE (IdPokemon);
ALTER TABLE Pokemon ADD CONSTRAINT chk_peso CHECK (Peso > 0);
ALTER TABLE Pokemon ADD CONSTRAINT chk_puntos_de_combate CHECK (PuntosDeCombate >= 0);
ALTER TABLE Pokemon ADD CONSTRAINT chk_sexo CHECK (Sexo IN ('M', 'H', 'Otro'));

------------- TORNEOS ------------


-- ========
-- TorneoCapturaShinys 
-- ========
CREATE TABLE TorneoCapturaShinys (
    Edicion INTEGER ,
    IdTorneo INTEGER ,
    IdPersona INTEGER,
    CantidadAPremiar REAL 
);
   
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT pk_torneo_captura_shinys PRIMARY KEY (Edicion, IdTorneo);
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT fk_torneo_captura_shinys_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT fk_torneo_captura_shinys_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

ALTER TABLE TorneoCapturaShinys ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE TorneoCapturaShinys ALTER COLUMN IdTorneo SET NOT NULL;

ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT chk_cantidad_a_premiar CHECK (CantidadAPremiar >= 0);
ALTER TABLE TorneoCapturaShinys ALTER COLUMN CantidadAPremiar DEFAULT 500.0;
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT uq_torneo_captura_shinys UNIQUE (IdTorneo);

-- ========
-- TorneoDistanciaRecorrida
-- ========
CREATE TABLE TorneoDistanciaRecorrida (
    Edicion INTEGER,
    IdTorneo INTEGER,
    IdPersona INTEGER,
    CantidadAPremiar REAL
);

ALTER TABLE TorneoDistanciaRecorrida ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE TorneoDistanciaRecorrida ALTER COLUMN IdTorneo SET NOT NULL;
ALTER TABLE TorneoDistanciaRecorrida ALTER COLUMN CantidadAPremiar SET DEFAULT 500.0;
ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT uq_torneo_distancia_recorrida UNIQUE (IdTorneo);

ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT pk_torneo_distancia_recorrida PRIMARY KEY (Edicion, IdTorneo);
ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT fk_torneo_distancia_recorrida_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);
ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT fk_torneo_distancia_recorrida_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

-- ========
-- TorneoPelea 
-- =======
CREATE TABLE TorneoPelea (
    Edicion INTEGER,
    IdTorneo INTEGER,
    IdPersona INTEGER,
    CantidadAPremiar REAL
);

ALTER TABLE TorneoPelea ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE TorneoPelea ALTER COLUMN IdTorneo SET NOT NULL;
ALTER TABLE TorneoPelea ALTER COLUMN IdTorneo SET UNIQUE;
ALTER TABLE TorneoPelea ALTER COLUMN CantidadAPremiar SET DEFAULT 500.0;

ALTER TABLE TorneoPelea ADD CONSTRAINT pk_torneo_pelea PRIMARY KEY (Edicion, IdTorneo);
ALTER TABLE TorneoPelea ADD CONSTRAINT fk_torneo_pelea_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);
ALTER TABLE TorneoPelea ADD CONSTRAINT fk_torneo_pelea_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);



-- ========
-- PeleaTorneo 
-- =======
CREATE TABLE PeleaTorneo (
    Edicion INTEGER,
    IdTorneo INTEGER,
    NumeroPelea INTEGER,
    IdPersona INTEGER,
    CodigoDeEntrenador INTEGER,
    Fecha DATE,
    Fase INTEGER
);

ALTER TABLE PeleaTorneo ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE PeleaTorneo ALTER COLUMN IdTorneo SET NOT NULL;
ALTER TABLE PeleaTorneo ALTER COLUMN NumeroPelea SET NOT NULL;
ALTER TABLE PeleaTorneo ALTER COLUMN CodigoDeEntrenador SET NOT NULL;
ALTER TABLE PeleaTorneo ALTER COLUMN Fecha SET NOT NULL;
ALTER TABLE PeleaTorneo ALTER COLUMN Fase SET NOT NULL;
ALTER TABLE PeleaTorneo ADD CONSTRAINT uq_numero_pelea UNIQUE (NumeroPelea);

ALTER TABLE PeleaTorneo ADD CONSTRAINT pk_pelea_torneo PRIMARY KEY (Edicion, IdTorneo, NumeroPelea);
ALTER TABLE PeleaTorneo ADD CONSTRAINT fk_pelea_torneo_torneo FOREIGN KEY (Edicion, IdTorneo) REFERENCES TorneoPelea(Edicion, IdTorneo);
ALTER TABLE PeleaTorneo ADD CONSTRAINT fk_pelea_torneo_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador);

-- ========
-- DistanciaRecorrida
-- ========
CREATE TABLE DistanciaRecorrida (
    Edicion INTEGER,
    IdTorneo INTEGER,
    IdDistancia INTEGER,
    IdPersona INTEGER,
    CodigoDeEntrenador INTEGER,
    Locacion VARCHAR(10),
    Fecha DATE,
    Hora TIMETZ
);

ALTER TABLE DistanciaRecorrida ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE DistanciaRecorrida ALTER COLUMN IdTorneo SET NOT NULL;
ALTER TABLE DistanciaRecorrida ALTER COLUMN IdDistancia SET NOT NULL;
ALTER TABLE DistanciaRecorrida ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE DistanciaRecorrida ALTER COLUMN CodigoDeEntrenador SET NOT NULL;
ALTER TABLE DistanciaRecorrida ALTER COLUMN Locacion SET NOT NULL;
ALTER TABLE DistanciaRecorrida ALTER COLUMN Fecha SET NOT NULL;
ALTER TABLE DistanciaRecorrida ALTER COLUMN Hora SET NOT NULL;
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT uq_distancia_recorrida UNIQUE (IdDistancia);
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT chk_locacion CHECK (Locacion IN ('Universum', 'Entrada', 'Rectoria'));

ALTER TABLE DistanciaRecorrida ADD CONSTRAINT pk_distancia_recorrido PRIMARY KEY (Edicion, IdTorneo, IdDistancia);
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT fk_distancia_recorrida_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador);
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT fk_distancia_recorrida_torneo_distancia_recorrida FOREIGN KEY (Edicion, IdTorneo) REFERENCES TorneoDistanciaRecorrida(Edicion, IdTorneo);


-- ========
-- Utilizar 
-- ========
CREATE TABLE Utilizar (
    IdPokemon INTEGER,
    Edicion INTEGER,
    IdTorneo INTEGER,
    NumeroPelea INTEGER
);

ALTER TABLE Utilizar ALTER COLUMN IdPokemon SET NOT NULL;
ALTER TABLE Utilizar ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE Utilizar ALTER COLUMN IdTorneo SET NOT NULL;
ALTER TABLE Utilizar ALTER COLUMN NumeroPelea SET NOT NULL;

ALTER TABLE Utilizar ADD CONSTRAINT fk_utilizar_pokemon FOREIGN KEY (IdPokemon) REFERENCES Pokemon(IdPokemon);
ALTER TABLE Utilizar ADD CONSTRAINT fk_utilizar_pelea_torneo FOREIGN KEY (Edicion, IdTorneo, NumeroPelea) REFERENCES PeleaTorneo(Edicion, IdTorneo, NumeroPelea);



-- ========
-- CapturaPokemon
-- ========
CREATE TABLE CapturaPokemon (
    Edicion INTEGER,
    IdTorneo INTEGER,
    IdCaptura INTEGER
);

ALTER TABLE CapturaPokemon ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE CapturaPokemon ALTER COLUMN IdTorneo SET NOT NULL;
ALTER TABLE CapturaPokemon ALTER COLUMN IdCaptura SET NOT NULL;
ALTER TABLE CapturaPokemon ADD CONSTRAINT uq_idcaptura UNIQUE (IdCaptura);


ALTER TABLE CapturaPokemon ADD CONSTRAINT pk_captura_pokemon PRIMARY KEY (Edicion, IdTorneo, IdCaptura);
ALTER TABLE CapturaPokemon ADD CONSTRAINT fk_captura_pokemon_torneo_captura_shinys FOREIGN KEY (Edicion, IdTorneo) REFERENCES TorneoCapturaShinys(Edicion, IdTorneo);

-- ========
--  Registrar
-- ========
CREATE TABLE Registrar (
    IdPokemon INTEGER,
    CodigoDeEntrenador INTEGER,
    IdPersona INTEGER,
    IdCaptura INTEGER,
    Edicion INTEGER,
    IdTorneo INTEGER,
    Fecha DATE,
    Hora TIMETZ
);

ALTER TABLE Registrar ALTER COLUMN IdPokemon SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN CodigoDeEntrenador SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN IdCaptura SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN IdTorneo SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN Fecha SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN Hora SET NOT NULL;


ALTER TABLE Registrar ADD CONSTRAINT fk_registrar_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador);
ALTER TABLE Registrar ADD CONSTRAINT fk_registrar_captura_pokemon FOREIGN KEY (Edicion, IdTorneo, IdCaptura) REFERENCES CapturaPokemon(Edicion, IdTorneo, IdCaptura);
ALTER TABLE Registrar ADD CONSTRAINT fk_registrar_pokemon FOREIGN KEY (IdPokemon) REFERENCES Pokemon(IdPokemon);

