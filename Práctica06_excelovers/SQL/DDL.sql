-- ========
--  Evento 
-- =======
CREATE TABLE Evento (
    Edicion INTEGER NOT NULL UNIQUE,
    Fecha DATE NOT NULL
);

ALTER TABLE Evento ADD CONSTRAINT pk_evento PRIMARY KEY (Edicion);

COMMENT ON TABLE Evento IS 'Tabla que almacena la información de los torneos de pokémon go.';
COMMENT ON COLUMN Evento.Edicion IS 'Número de edición del evento.';
COMMENT ON COLUMN Evento.Fecha IS 'Fecha en la que se lleva a cabo el evento.';
COMMENT ON CONSTRAINT pk_evento ON Evento IS 'Restricción de entidad para la tabla Evento.';

------------------- PERSONAS -------------------
-- ========
--  ParticipanteUNAM
-- ========
CREATE TABLE ParticipanteUNAM (
    IdPersona INTEGER NOT NULL UNIQUE ,
    NumeroDeCuenta INTEGER NOT NULL UNIQUE,
    Nombre VARCHAR(20) NOT NULL,
    ApellidoMaterno VARCHAR(20) NOT NULL,
    ApellidoPaterno VARCHAR(20) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo VARCHAR(10) CHECK (Sexo IN ('M', 'H', 'Otro')),
    Carrera VARCHAR(20) NOT NULL,
    Facultad VARCHAR(20) NOT NULL
);

ALTER TABLE ParticipanteUNAM 
ADD CONSTRAINT pk_ParticipanteUNAM PRIMARY KEY (IdPersona);

COMMENT ON TABLE ParticipanteUNAM IS 'Tabla que almacena los datos personales de los participantes de la UNAM en el torneo';

COMMENT ON COLUMN ParticipanteUNAM.IdPersona IS 'Identificador único del participante dentro del sistema';
COMMENT ON COLUMN ParticipanteUNAM.NumeroDeCuenta IS 'Número de cuenta de la UNAM del participante';
COMMENT ON COLUMN ParticipanteUNAM.Nombre IS 'Nombre del participante';
COMMENT ON COLUMN ParticipanteUNAM.ApellidoPaterno IS 'Apellido materno del participante';
COMMENT ON COLUMN ParticipanteUNAM.ApellidoMaterno IS 'Apellido paterno del participante';
COMMENT ON COLUMN ParticipanteUNAM.FechaNacimiento IS 'Fecha de nacimiento del participante en formato YYYY-MM-DD';
COMMENT ON COLUMN ParticipanteUNAM.Sexo IS 'Sexo o identidad de género del participante (M, H u Otro)';
COMMENT ON COLUMN ParticipanteUNAM.Carrera IS 'Carrera universitaria que cursa el participante';
COMMENT ON COLUMN ParticipanteUNAM.Facultad IS 'Facultad de la UNAM a la que pertenece el participante';

COMMENT ON CONSTRAINT PK_ParticipanteUNAM ON ParticipanteUNAM IS 'Llave primaria que identifica de forma única a cada participante.';
COMMENT ON CONSTRAINT CK_Sexo ON ParticipanteUNAM IS 'Restricción CHECK que valida que el valor de Sexo sea M, H u Otro.';
COMMENT ON CONSTRAINT UQ_NumeroDeCuenta ON ParticipanteUNAM IS 'Restricción UNIQUE que asegura que el número de cuenta de la UNAM no se repita entre participantes.';

-- ========
-- EncargadoRegistro 
-- ========
 
CREATE TABLE EncargadoRegistro (
    IdPersona INTEGER NOT NULL UNIQUE , 
    Nombre VARCHAR(20) NOT NULL,
    ApellidoMaterno VARCHAR(20) NOT NULL,
    ApellidoPaterno VARCHAR(20) NOT NULL,
    FechaDeNacimiento DATE NOT NULL,
    Sexo VARCHAR(10) NOT NULL CHECK (Sexo IN ('M', 'H', 'Otro')),
    Calle VARCHAR(20) NOT NULL,
    Colonia VARCHAR(20) NOT NULL,
    Ciudad VARCHAR(20) NOT NULL,
    CodigoPostal INTEGER NOT NULL, 
    NumInterior INTEGER NOT NULL, 
    NumExterior INTEGER NOT NULL, 
    EsJugador BOOLEAN NOT NULL
);

ALTER TABLE EncargadoRegistro ADD CONSTRAINT pk_encargado_registro PRIMARY KEY (IdPersona);

COMMENT ON TABLE EncargadoRegistro IS 'Tabla que contiene los datos de los encargados de registro.';
COMMENT ON COLUMN EncargadoRegistro.IdPersona IS 'Identificador único del encargado de registro.';
COMMENT ON COLUMN EncargadoRegistro.Nombre IS 'Nombre del encargado de registro.';
COMMENT ON COLUMN EncargadoRegistro.ApellidoMaterno IS 'Apellido materno del encargado de registro.';
COMMENT ON COLUMN EncargadoRegistro.ApellidoPaterno IS 'Apellido paterno del encargado de registro.';
COMMENT ON COLUMN EncargadoRegistro.FechaDeNacimiento IS 'Fecha de nacimiento del encargado de registro.';
COMMENT ON COLUMN EncargadoRegistro.Sexo IS 'Sexo del encargado de registro; valores permitidos: M, H, Otro.';
COMMENT ON COLUMN EncargadoRegistro.Calle IS 'Calle de residencia del encargado de registro.';
COMMENT ON COLUMN EncargadoRegistro.Colonia IS 'Colonia de residencia del encargado de registro.';
COMMENT ON COLUMN EncargadoRegistro.Ciudad IS 'Ciudad de residencia del encargado de registro.';
COMMENT ON COLUMN EncargadoRegistro.CodigoPostal IS 'Código postal de la dirección del encargado de registro.';
COMMENT ON COLUMN EncargadoRegistro.NumInterior IS 'Número interior de la vivienda del encargado de registro.';
COMMENT ON COLUMN EncargadoRegistro.NumExterior IS 'Número exterior de la vivienda del encargado de registro.';
COMMENT ON COLUMN EncargadoRegistro.EsJugador IS 'Indica si el encargado de registro también es jugador (TRUE) o no (FALSE).';

COMMENT ON CONSTRAINT pk_encargado_registro ON EncargadoRegistro IS 'Llave primaria de la tabla EncargadoRegistro, compuesta por IdPersona.';


-- ========
-- Vendedor 
-- =======
CREATE TABLE Vendedor (
    IdPersona INTEGER NOT NULL UNIQUE , 
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

COMMENT ON TABLE Vendedor IS 'Tabla para almacenar la información de los venderores.';
COMMENT ON COLUMN Vendedor.IdPersona IS 'Identificador único del vendedor (PK).';
COMMENT ON COLUMN Vendedor.Nombre IS 'Nombre del vendedor.';
COMMENT ON COLUMN Vendedor.ApellidoMaterno IS 'Apellido materno del vendedor.';
COMMENT ON COLUMN Vendedor.ApellidoPaterno IS 'Apellido paterno del vendedor.';
COMMENT ON COLUMN Vendedor.FechaNacimiento IS 'Fecha de nacimiento del vendedor.';
COMMENT ON COLUMN Vendedor.Sexo IS 'Sexo del vendedor.';
COMMENT ON COLUMN Vendedor.Calle IS 'Calle de residencia del vendedor.';
COMMENT ON COLUMN Vendedor.Colonia IS 'Colonia de residencia del vendedor.';
COMMENT ON COLUMN Vendedor.Ciudad IS 'Ciudad de residencia del vendedor.';
COMMENT ON COLUMN Vendedor.CodigoPostal IS 'Código postal del vendedor.';
COMMENT ON COLUMN Vendedor.NumInterior IS 'Número interior del vendedor.';
COMMENT ON COLUMN Vendedor.NumExterior IS 'Número exterior del vendedor.';
COMMENT ON COLUMN Vendedor.Ubicacion IS 'Ubicación asignada del vendedor.';
COMMENT ON CONSTRAINT pk_vendedor ON Vendedor IS 'Restricción de entidad para la tabla Vendedor.';


-- ========
-- Cuidador
-- =======
CREATE TABLE Cuidador (
    IdPersona INTEGER NOT NULL UNIQUE ,
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

COMMENT ON TABLE Cuidador IS 'Tabla que almacena la información de los cuidadores del evento.';
COMMENT ON COLUMN Cuidador.IdPersona IS 'Identificador único del cuidador.';
COMMENT ON COLUMN Cuidador.Nombre IS 'Nombre del cuidador.';
COMMENT ON COLUMN Cuidador.ApellidoMaterno IS 'Apellido materno del cuidador.';
COMMENT ON COLUMN Cuidador.ApellidoPaterno IS 'Apellido paterno del cuidador.';
COMMENT ON COLUMN Cuidador.FechaNacimiento IS 'Fecha de nacimiento del cuidador.';
COMMENT ON COLUMN Cuidador.Sexo IS 'Sexo del cuidador.';
COMMENT ON COLUMN Cuidador.Calle IS 'Calle de residencia del cuidador.';
COMMENT ON COLUMN Cuidador.Colonia IS 'Colonia de residencia del cuidador.';
COMMENT ON COLUMN Cuidador.Ciudad IS 'Ciudad de residencia del cuidador.';
COMMENT ON COLUMN Cuidador.CodigoPostal IS 'Código postal de la residencia del cuidador.';
COMMENT ON COLUMN Cuidador.NumInterior IS 'Número interior de la residencia del cuidador.';
COMMENT ON COLUMN Cuidador.NumExterior IS 'Número exterior de la residencia del cuidador.';
COMMENT ON COLUMN Cuidador.Ubicacion IS 'Ubicación asignada al cuidador dentro del evento.';
COMMENT ON COLUMN Cuidador.Horario IS 'Horario de trabajo del cuidador.';
COMMENT ON COLUMN Cuidador.Salario IS 'Salario asignado al cuidador.';
COMMENT ON CONSTRAINT pk_cuidador ON Cuidador IS 'Restricción de entidad para la tabla Cuidador.';

-- ========
-- Limpiador 
-- =======
CREATE TABLE Limpiador (
    IdPersona INTEGER NOT NULL  UNIQUE ,
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

COMMENT ON TABLE Limpiador IS 'Tabla que almacena la información de los limpiadores del evento.';
COMMENT ON COLUMN Limpiador.IdPersona IS 'Identificador único de la persona limpiadora.';
COMMENT ON COLUMN Limpiador.Nombre IS 'Nombre de la persona limpiadora.';
COMMENT ON COLUMN Limpiador.ApellidoMaterno IS 'Apellido materno de la persona limpiadora.';
COMMENT ON COLUMN Limpiador.ApellidoPaterno IS 'Apellido paterno de la persona limpiadora.';
COMMENT ON COLUMN Limpiador.FechaNacimiento IS 'Fecha de nacimiento de la persona limpiadora.';
COMMENT ON COLUMN Limpiador.Sexo IS 'Sexo de la persona limpiadora.';
COMMENT ON COLUMN Limpiador.Calle IS 'Calle de residencia de la persona limpiadora.';
COMMENT ON COLUMN Limpiador.Colonia IS 'Colonia de residencia de la persona limpiadora.';
COMMENT ON COLUMN Limpiador.Ciudad IS 'Ciudad de residencia de la persona limpiadora.';
COMMENT ON COLUMN Limpiador.CodigoPostal IS 'Código postal de la residencia de la persona limpiadora.';
COMMENT ON COLUMN Limpiador.NumInterior IS 'Número interior de la residencia de la persona limpiadora.';
COMMENT ON COLUMN Limpiador.NumExterior IS 'Número exterior de la residencia de la persona limpiadora.';
COMMENT ON COLUMN Limpiador.Ubicacion IS 'Ubicación asignada al limpiador dentro del evento.';
COMMENT ON COLUMN Limpiador.Horario IS 'Horario de trabajo del limpiador.';
COMMENT ON COLUMN Limpiador.Salario IS 'Salario asignado al limpiador.';
COMMENT ON CONSTRAINT pk_limpiador ON Limpiador IS 'Restricción de entidad para la tabla Limpiador.';

-- ========
-- Espectador
-- ========
CREATE TABLE Espectador (
    IdPersona INTEGER NOT NULL ,
    Nombre VARCHAR(20) NOT NULL,
    ApellidoMaterno VARCHAR(20) NOT NULL,
    ApellidoPaterno VARCHAR(20) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo VARCHAR(10) CHECK (Sexo IN ('M', 'H', 'Otro')),
    HoraIngreso TIMETZ,
    HoraSalida TIMETZ CHECK (HoraSalida >= HoraIngreso)
);

ALTER TABLE Espectador 
ADD CONSTRAINT pk_Espectador PRIMARY KEY (IdPersona);

COMMENT ON TABLE Espectador IS 'Tabla que almacena los datos personales de los espectadores de los torneos';

COMMENT ON COLUMN Espectador.IdPersona IS 'Identificador único del participante dentro del sistema';
COMMENT ON COLUMN Espectador.Nombre IS 'Nombre del espectador';
COMMENT ON COLUMN ParticipanteUNAM.ApellidoMaterno IS 'Apellido materno del espectador';
COMMENT ON COLUMN ParticipanteUNAM.ApellidoPaterno IS 'Apellido paterno del espectador';
COMMENT ON COLUMN ParticipanteUNAM.FechaNacimiento IS 'Fecha de nacimiento del espectador en formato YYYY-MM-DD';
COMMENT ON COLUMN ParticipanteUNAM.Sexo IS 'Sexo o identidad de género del participante (M, H u Otro)';
COMMENT ON COLUMN ParticipanteUNAM.HoraIngreso IS 'Hora de ingreso del espectador al evento';
COMMENT ON COLUMN ParticipanteUNAM.HoraSalida IS 'Hora de salida del espectador al evento';

COMMENT ON CONSTRAINT PK_Espectador ON Espectador IS 'Llave primaria que identifica de forma única a cada espectador';


-- DATOS -------------------------------------


-- ========
-- 7. CorreoCuidador 
-- =======
CREATE TABLE CorreoCuidador (
    IdPersona INTEGER NOT NULL,
    Correo VARCHAR (50) NOT NULL
);
ALTER TABLE CorreoCuidador ADD CONSTRAINT pk_correo_cuidador PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoCuidador ADD CONSTRAINT fk_correo_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE CorreoCuidador IS 'Tabla que almacena los correos electrónicos de los cuidadores.';
COMMENT ON COLUMN CorreoCuidador.IdPersona IS 'Identificador único del cuidador.';
COMMENT ON COLUMN CorreoVendedor.Correo IS 'Correo electrónico del cuidador.';
COMMENT ON CONSTRAINT pk_correo_cuidador ON CorreoCuidador IS 'Restricción de entidad para la tabla CorreoCuidador.';
COMMENT ON CONSTRAINT fk_correo_cuidador_cuidador ON CorreoCuidador IS 'Restricción referencial que vincula CorreoCuidador con Cuidador.';

-- ========
-- 8. TelefonoCuidador
-- =======
CREATE TABLE TelefonoCuidador(
    IdPersona INTEGER NOT NULL,
    Telefono CHAR(10) NOT NULL
);
ALTER TABLE TelefonoCuidador ADD CONSTRAINT pk_telefono_cuidador PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoCuidador ADD CONSTRAINT fk_telefono_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE TelefonoCuidador IS 'Tabla que almacena los teléfonos de los cuidadores.';
COMMENT ON COLUMN TelefonoCuidador.IdPersona IS 'Identificador único del cuidador.';
COMMENT ON COLUMN TelefonoCuidador.Telefono IS 'Número de teléfono del cuidador.';
COMMENT ON CONSTRAINT pk_correo_cuidador ON CorreoCuidador IS 'Restricción de entidad para la tabla TeléfonoCuidador.';
COMMENT ON CONSTRAINT fk_correo_cuidador_cuidador ON CorreoCuidador IS 'Restricción referencial que vincula TelefonoCuidador con Cuidador.';

-- ========
-- 4. CorreoEncargadoRegistro (Va después de EncargadoRegistro)
-- =======
CREATE TABLE CorreoEncargadoRegistro (
    IdPersona INTEGER NOT NULL,
    Correo VARCHAR(50) NOT NULL
);

ALTER TABLE CorreoEncargadoRegistro ADD CONSTRAINT pk_correo_encargado_registro PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoEncargadoRegistro ADD CONSTRAINT fk_correo_encargado_registro FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE CorreoEncargadoRegistro IS 'Tabla que almacena los correos electrónicos asociados a cada encargado de registro.';
COMMENT ON COLUMN CorreoEncargadoRegistro.IdPersona IS 'Identificador del encargado de registro al que pertenece el correo (llave foránea hacia EncargadoRegistro).';
COMMENT ON COLUMN CorreoEncargadoRegistro.Correo IS 'Dirección de correo electrónico del encargado de registro.';

COMMENT ON CONSTRAINT pk_correo_encargado_registro ON CorreoEncargadoRegistro IS 'Llave primaria compuesta por IdPersona y Correo.';
COMMENT ON CONSTRAINT fk_correo_encargado_registro ON CorreoEncargadoRegistro IS 'Llave foránea que referencia al encargado de registro correspondiente, con política ON DELETE RESTRICT ON UPDATE CASCADE.';

-- ========
-- 5. TelefonoEncargadoRegistro (Va después de EncargadoRegistro)
-- =======
CREATE TABLE TelefonoEncargadoRegistro (
    IdPersona INTEGER NOT NULL,
    Telefono CHAR(10) NOT NULL
);
ALTER TABLE TelefonoEncargadoRegistro ADD CONSTRAINT pk_telefono_encargado_registro PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoEncargadoRegistro ADD CONSTRAINT fk_telefono_encargado_registro FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE TelefonoEncargadoRegistro IS 'Tabla que almacena los números telefónicos asociados a cada encargado de registro.';
COMMENT ON COLUMN TelefonoEncargadoRegistro.IdPersona IS 'Identificador del encargado de registro al que pertenece el número telefónico (llave foránea hacia EncargadoRegistro).';
COMMENT ON COLUMN TelefonoEncargadoRegistro.Telefono IS 'Número telefónico del encargado de registro; debe contener 10 dígitos.';

COMMENT ON CONSTRAINT pk_telefono_encargado_registro ON TelefonoEncargadoRegistro IS 'Llave primaria compuesta por IdPersona y Telefono.';
COMMENT ON CONSTRAINT fk_telefono_encargado_registro ON TelefonoEncargadoRegistro IS 'Llave foránea que referencia al encargado de registro correspondiente, con política ON DELETE RESTRICT ON UPDATE CASCADE.';


-- ========
-- 3. CorreoLimpiador (Va después de Limpiador)
-- =======
CREATE TABLE CorreoLimpiador (
    IdPersona INTEGER NOT NULL,
    Correo VARCHAR(50) NOT NULL
);
ALTER TABLE CorreoLimpiador ADD CONSTRAINT pk_correo_limpiador PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoLimpiador ADD CONSTRAINT fk_correo_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona);

COMMENT ON TABLE CorreoLimpiador IS 'Tabla que almacena los correos electrónicos de los limpiadores.';
COMMENT ON COLUMN CorreoLimpiador.IdPersona IS 'Identificador único de la persona limpiadora.';
COMMENT ON COLUMN CorreoLimpiador.Correo IS 'Correo electrónico de la persona limpiadora.';
COMMENT ON CONSTRAINT pk_correo_limpiador ON CorreoLimpiador IS 'Restricción de entidad para la tabla CorreoLimpiador.';
COMMENT ON CONSTRAINT fk_correo_limpiador_limpiador ON CorreoLimpiador IS 'Restricción referencial que vincula CorreoLimpiador con Limpiador.';

-- ========
-- 4. TelefonoLimpiador (Va después de Limpiador)
-- =======
CREATE TABLE TelefonoLimpiador (
    IdPersona INTEGER NOT NULL,
    Telefono CHAR(10) NOT NULL
);
ALTER TABLE TelefonoLimpiador ADD CONSTRAINT pk_telefono_limpiador PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoLimpiador ADD CONSTRAINT fk_telefono_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona);

COMMENT ON TABLE TelefonoLimpiador IS 'Tabla que almacena los teléfonos de los limpiadores.';
COMMENT ON COLUMN TelefonoLimpiador.IdPersona IS 'Identificador único de la persona limpiadora.';
COMMENT ON COLUMN TelefonoLimpiador.Telefono IS 'Número de teléfono de la persona limpiadora.';
COMMENT ON CONSTRAINT pk_telefono_limpiador ON TelefonoLimpiador IS 'Restricción de entidad para la tabla TelefonoLimpiador.';
COMMENT ON CONSTRAINT fk_telefono_limpiador_limpiador ON TelefonoLimpiador IS 'Restricción referencial que vincula TelefonoLimpiador con Limpiador.';

-- ========
-- 3. CorreoVendedor 
-- =======
CREATE TABLE CorreoVendedor(
    IdPersona INTEGER NOT NULL,
    Correo VARCHAR(50) NOT NULL
);
ALTER TABLE CorreoVendedor ADD CONSTRAINT pk_correo_vendedor PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoVendedor ADD CONSTRAINT fk_correo_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE CorreoVendedor IS 'Tabla que almacena los correos electrónicos de los vendedores.';
COMMENT ON COLUMN CorreoVendedor.IdPersona IS 'Identificador único del vendedor.';
COMMENT ON COLUMN CorreoVendedor.Correo IS 'Correo electrónico del vendedor.';
COMMENT ON CONSTRAINT pk_correo_vendedor ON CorreoVendedor IS 'Restricción de entidad para la tabla CorreoVendedor.';
COMMENT ON CONSTRAINT fk_correo_vendedor_vendedor ON CorreoVendedor IS 'Restricción referencial que vincula CorreoVendedor con Vendedor.';

-- ========
-- 4. TelefonoVendedor 
-- =======
CREATE TABLE TelefonoVendedor(
    IdPersona INTEGER NOT NULL,
    Telefono CHAR(10) NOT NULL
);
ALTER TABLE TelefonoVendedor ADD CONSTRAINT pk_telefono_vendedor PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoVendedor ADD CONSTRAINT fk_telefono_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE TelefonoVendedor IS 'Tabla que almacena los teléfonos de los vendedores.';
COMMENT ON COLUMN TelefonoVendedor.IdPersona IS 'Identificador único del vendedor.';
COMMENT ON COLUMN TelefonoVendedor.Telefono IS 'Número de teléfono del vendedor.';
COMMENT ON CONSTRAINT pk_correo_vendedor ON CorreoVendedor IS 'Restricción de entidad para la tabla TeléfonoVendedor.';
COMMENT ON CONSTRAINT fk_correo_vendedor_vendedor ON CorreoVendedor IS 'Restricción referencial que vincula TelefonoVendedor con Vendedor.';

-- ========
-- 5. CorreoParticipante
-- ========
CREATE TABLE CorreoParticipante (
    IdPersona INTEGER NOT NULL,
    Correo VARCHAR(50) NOT NULL
);

ALTER TABLE CorreoParticipante 
ADD CONSTRAINT pk_CorreoParticipante PRIMARY KEY (IdPersona, Correo);

ALTER TABLE CorreoParticipante 
ADD CONSTRAINT FK_Participante_Correo FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona)
ON DELETE CASCADE
ON UPDATE CASCADE;


COMMENT ON TABLE CorreoParticipante IS 'Tabla que almacena las direcciones de correo electrónico asociadas a cada participante de la UNAM.';

COMMENT ON COLUMN CorreoParticipante.IdPersona IS 'Identificador del participante al que pertenece el correo.';
COMMENT ON COLUMN CorreoParticipante.Correo IS 'Dirección de correo electrónico del participante. Puede haber más de una por persona.';

COMMENT ON CONSTRAINT PK_CorreoParticipante ON CorreoParticipante IS 'Llave primaria compuesta que asegura que un mismo participante no tenga correos repetidos.';
COMMENT ON CONSTRAINT FK_Participante_Correo ON CorreoParticipante IS 'Llave foránea que vincula cada correo con el participante correspondiente. Se eliminan los correos si el participante es eliminado.';

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
ADD CONSTRAINT FK_Telefono_Participante 
FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona)
ON DELETE CASCADE
ON UPDATE CASCADE;

COMMENT ON TABLE TelefonoParticipante IS 'Tabla que almacena los números telefónicos asociados a los participantes de la UNAM.';

COMMENT ON COLUMN TelefonoParticipante.IdPersona IS 'Identificador del participante de la UNAM al que pertenece el número telefónico';
COMMENT ON COLUMN TelefonoParticipante.Telefono IS 'Número telefónico de contacto del participante. Se almacena con una longitud fija de 10 dígitos';

COMMENT ON CONSTRAINT PK_TelefonoParticipante ON TelefonoParticipante IS 'Llave primaria compuesta que impide duplicar números telefónicos para un mismo participante.';
COMMENT ON CONSTRAINT FK_Telefono_Participante ON TelefonoParticipante IS 'Llave foránea que vincula cada teléfono con el participante correspondiente. Se eliminan los teléfonos en cascada si el participante es eliminado.';


---- TRABAJAR -------------------------------------------------
-- ========
-- TrabajarVendedor 
-- =======
CREATE TABLE TrabajarVendedor(
    Edicion INTEGER NOT NULL,
    IdPersona INTEGER NOT NULL
);
ALTER TABLE TrabajarVendedor ADD CONSTRAINT fk_trabajar_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;
ALTER TABLE TrabajarVendedor ADD CONSTRAINT fk_trabajar_vendedor_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE TrabajarVendedor IS 'Tabla que registra la relación de trabajo entre los vendedores y los eventos.';
COMMENT ON COLUMN TrabajarVendedor.IdPersona IS 'Identificador único del vendedor.';
COMMENT ON COLUMN TrabajarVendedor.Edicion IS 'Edición del evento en la que el vendedor trabaja.';
COMMENT ON CONSTRAINT fk_trabajar_vendedor_vendedor ON TrabajarVendedor IS 'Restricción referencial que vincula TrabajarVendedor con Vendedor.';
COMMENT ON CONSTRAINT fk_trabajar_vendedor_evento ON TrabajarVendedor IS 'Restricción referencial que vincula TrabajarVendedor con Evento.';

-- ========
-- TrabajarCuidador 
-- =======
CREATE TABLE TrabajarCuidador (
    Edicion INTEGER NOT NULL, 
    IdPersona INTEGER NOT NULL
);

ALTER TABLE TrabajarCuidador 
ADD CONSTRAINT fk_trabajar_cuidador_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE TrabajarCuidador 
ADD CONSTRAINT fk_trabajar_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE TrabajarCuidador IS 'Tabla que registra la participación de los cuidadores en diferentes ediciones de eventos.';
COMMENT ON COLUMN TrabajarCuidador.Edicion IS 'Número de edición del evento en el que participa el cuidador (llave foránea hacia Evento).';
COMMENT ON COLUMN TrabajarCuidador.IdPersona IS 'Identificador del cuidador que trabaja en la edición (llave foránea hacia Cuidador).';

COMMENT ON CONSTRAINT fk_trabajar_cuidador_evento ON TrabajarCuidador IS 'Llave foránea que referencia la edición del evento, con política ON DELETE RESTRICT ON UPDATE CASCADE.';
COMMENT ON CONSTRAINT fk_trabajar_cuidador_cuidador ON TrabajarCuidador IS 'Llave foránea que referencia al cuidador que trabaja en la edición, con política ON DELETE RESTRICT ON UPDATE CASCADE.';


-- ========
--  TrabajarLimpiador
-- =======
CREATE TABLE TrabajarLimpiador (
    IdPersona INTEGER NOT NULL,
    Edicion INTEGER NOT NULL
);
ALTER TABLE TrabajarLimpiador ADD CONSTRAINT fk_trabajar_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona);
ALTER TABLE TrabajarLimpiador ADD CONSTRAINT fk_trabajar_limpiador_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);

COMMENT ON TABLE TrabajarLimpiador IS 'Tabla que registra la relación de trabajo entre los limpiadores y los eventos.';
COMMENT ON COLUMN TrabajarLimpiador.IdPersona IS 'Identificador único de la persona limpiadora.';
COMMENT ON COLUMN TrabajarLimpiador.Edicion IS 'Edición del evento en la que el limpiador trabaja.';
COMMENT ON CONSTRAINT fk_trabajar_limpiador_limpiador ON TrabajarLimpiador IS 'Restricción referencial que vincula TrabajarLimpiador con Limpiador.';
COMMENT ON CONSTRAINT fk_trabajar_limpiador_evento ON TrabajarLimpiador IS 'Restricción referencial que vincula TrabajarLimpiador con Evento.';




-- ========
-- TrabajarEncargadoRegistro 
-- =======

CREATE TABLE TrabajarEncargadoRegistro (
    Edicion INTEGER NOT NULL, 
    IdPersona INTEGER NOT NULL
);

ALTER TABLE TrabajarEncargadoRegistro 
ADD CONSTRAINT fk_trabajar_encargado_registro_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE TrabajarEncargadoRegistro 
ADD CONSTRAINT fk_trabajar_encargado_registro_encargado FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE TrabajarEncargadoRegistro IS 'Tabla que registra la participación de los encargados de registro en diferentes ediciones de eventos.';
COMMENT ON COLUMN TrabajarEncargadoRegistro.Edicion IS 'Número de edición del evento en el que participa el encargado (llave foránea hacia Evento).';
COMMENT ON COLUMN TrabajarEncargadoRegistro.IdPersona IS 'Identificador del encargado de registro que trabaja en la edición (llave foránea hacia EncargadoRegistro).';

COMMENT ON CONSTRAINT fk_trabajar_encargado_registro_evento ON TrabajarEncargadoRegistro IS 'Llave foránea que referencia la edición del evento, con política ON DELETE RESTRICT ON UPDATE CASCADE.';
COMMENT ON CONSTRAINT fk_trabajar_encargado_registro_encargado ON TrabajarEncargadoRegistro IS 'Llave foránea que referencia al encargado de registro que trabaja en la edición, con política ON DELETE RESTRICT ON UPDATE CASCADE.';


--- COMPRAS---------------------------------------------


-- ========
-- Alimento (Va después de Vendedor)
-- ========
CREATE TABLE Alimento (
    IdAlimento INTEGER NOT NULL UNIQUE , 
    IdPersona INTEGER NOT NULL, 
    FechaDeCaducidad DATE NOT NULL,
    Nombre VARCHAR(20) NOT NULL,
    Tipo VARCHAR(20) NOT NULL,
    Precio REAL NOT NULL CHECK (Precio > 0)
);

ALTER TABLE Alimento ADD CONSTRAINT pk_alimento PRIMARY KEY (IdAlimento);
ALTER TABLE Alimento ADD CONSTRAINT fk_alimento_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE Alimento IS 'Tabla que contiene los alimentos ofrecidos por los vendedores en el evento.';
COMMENT ON COLUMN Alimento.IdAlimento IS 'Identificador único del alimento.';
COMMENT ON COLUMN Alimento.IdPersona IS 'Identificador del vendedor que ofrece el alimento (llave foránea hacia Vendedor).';
COMMENT ON COLUMN Alimento.FechaDeCaducidad IS 'Fecha de caducidad del alimento.';
COMMENT ON COLUMN Alimento.Nombre IS 'Nombre del alimento.';
COMMENT ON COLUMN Alimento.Tipo IS 'Tipo o categoría del alimento.';
COMMENT ON COLUMN Alimento.Precio IS 'Precio del alimento; debe ser un valor positivo.';

COMMENT ON CONSTRAINT pk_alimento ON Alimento IS 'Llave primaria de la tabla Alimento.';
COMMENT ON CONSTRAINT fk_alimento_vendedor ON Alimento IS 'Llave foránea que referencia al vendedor correspondiente, con política ON DELETE RESTRICT ON UPDATE CASCADE.';


-- ======== 
-- ComprarEncargadoRegistro 
-- ========

CREATE TABLE ComprarEncargadoRegistro (
    IdPersona INTEGER NOT NULL, 
    IdAlimento INTEGER NOT NULL, 
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL NOT NULL CHECK (Cantidad > 0)
);

ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT fk_comprar_encargado_registro_encargado FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT fk_comprar_encargado_registro_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE ComprarEncargadoRegistro IS 'Tabla que registra las compras realizadas por los encargados de registro, incluyendo el método de pago y la cantidad adquirida.';
COMMENT ON COLUMN ComprarEncargadoRegistro.IdPersona IS 'Identificador del encargado de registro que realiza la compra (llave foránea hacia EncargadoRegistro).';
COMMENT ON COLUMN ComprarEncargadoRegistro.IdAlimento IS 'Identificador del alimento comprado (llave foránea hacia Alimento).';
COMMENT ON COLUMN ComprarEncargadoRegistro.MetodoDePago IS 'Método de pago utilizado en la compra; puede ser Tarjeta, Efectivo o Transferencia.';
COMMENT ON COLUMN ComprarEncargadoRegistro.Cantidad IS 'Cantidad de unidades del alimento compradas; debe ser mayor a 0.';

COMMENT ON CONSTRAINT fk_comprar_encargado_registro_encargado ON ComprarEncargadoRegistro IS 'Llave foránea que referencia al encargado de registro comprador, con política ON DELETE RESTRICT ON UPDATE CASCADE.';
COMMENT ON CONSTRAINT fk_comprar_encargado_registro_alimento ON ComprarEncargadoRegistro IS 'Llave foránea que referencia al alimento adquirido, con política ON DELETE RESTRICT ON UPDATE CASCADE.';

-- ========
-- ComprarLimpiador  
-- =======
CREATE TABLE ComprarLimpiador (
    IdPersona INTEGER NOT NULL,
    IdAlimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL NOT NULL CHECK (Cantidad > 0)
);
ALTER TABLE ComprarLimpiador ADD CONSTRAINT fk_comprar_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona);
ALTER TABLE ComprarLimpiador ADD CONSTRAINT fk_comprar_limpiador_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);

COMMENT ON TABLE ComprarLimpiador IS 'Tabla que registra las compras realizadas por los limpiadores.';
COMMENT ON COLUMN ComprarLimpiador.IdPersona IS 'Identificador único de la persona limpiadora que realiza la compra.';
COMMENT ON COLUMN ComprarLimpiador.IdAlimento IS 'Identificador único del alimento comprado.';
COMMENT ON COLUMN ComprarLimpiador.MetodoDePago IS 'Método de pago utilizado para la compra.';
COMMENT ON COLUMN ComprarLimpiador.Cantidad IS 'Cantidad de alimento comprada.';
COMMENT ON CONSTRAINT fk_comprar_limpiador_limpiador ON ComprarLimpiador IS 'Restricción referencial que vincula ComprarLimpiador con Limpiador.';
COMMENT ON CONSTRAINT fk_comprar_limpiador_alimento ON ComprarLimpiador IS 'Restricción referencial que vincula ComprarLimpiador con Alimento.';


-- ========
-- ComprarCuidador 
-- ========
CREATE TABLE ComprarCuidador (
    IdPersona INTEGER NOT NULL,
    IdAlimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL NOT NULL CHECK (Cantidad > 0)
);
ALTER TABLE ComprarCuidador ADD CONSTRAINT fk_comprar_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona);
ALTER TABLE ComprarCuidador ADD CONSTRAINT fk_comprar_cuidador_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento);

COMMENT ON TABLE ComprarCuidador IS 'Tabla que registra las compras realizadas por los cuidadores.';
COMMENT ON COLUMN ComprarCuidador.IdPersona IS 'Identificador único de la persona cuidadora que realiza la compra.';
COMMENT ON COLUMN ComprarCuidador.IdAlimento IS 'Identificador único del alimento comprado.';
COMMENT ON COLUMN ComprarCuidador.MetodoDePago IS 'Método de pago utilizado para la compra.';
COMMENT ON COLUMN ComprarCuidador.Cantidad IS 'Cantidad de alimento comprada.';
COMMENT ON CONSTRAINT fk_comprar_cuidador_cuidador ON ComprarCuidador IS 'Restricción referencial que vincula ComprarCuidador con Cuidador.';
COMMENT ON CONSTRAINT fk_comprar_cuidador_alimento ON ComprarCuidador IS 'Restricción referencial que vincula ComprarCuidador con Alimento.';


-- ========
-- ComprarVendedor 
-- =======
CREATE TABLE ComprarVendedor (
    IdPersona INTEGER NOT NULL,
    IdAlimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL NOT NULL CHECK (Cantidad > 0)
);
ALTER TABLE ComprarVendedor  ADD CONSTRAINT fk_comprar_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor (IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;
ALTER TABLE ComprarVendedor ADD CONSTRAINT fk_comprar_vendedor_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE ComprarVendedor IS 'Tabla que registra las compras realizadas por los vendedores.';
COMMENT ON COLUMN ComprarVendedor.IdPersona IS 'Identificador único del vendedor.';
COMMENT ON COLUMN ComprarVendedor.IdAlimento IS 'Identificador único del alimento comprado.';
COMMENT ON COLUMN ComprarVendedor.MetodoDePago IS 'Método de pago utilizado para la compra.';
COMMENT ON COLUMN ComprarVendedor.Cantidad IS 'Cantidad de alimento comprada.';
COMMENT ON CONSTRAINT fk_comprar_vendedor_vendedor ON ComprarVendedor IS 'Restricción referencial que vincula ComprarVendedor con Vendedor.';
COMMENT ON CONSTRAINT fk_comprar_vendedor_alimento ON ComprarVendedor IS 'Restricción referencial que vincula ComprarVendedor con Alimento.';

-- ========
-- ComprarEspectador
-- ========
CREATE TABLE ComprarEspectador (
    IdPersona INTEGER NOT NULL,
    IdAlimento INTEGER NOT NULL,
    MetodoDePago VARCHAR(20) NOT NULL CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Cantidad REAL CHECK (Cantidad > 0)
);

ALTER TABLE ComprarEspectador 
ADD CONSTRAINT FK_Espectador_Comprar FOREIGN KEY (IdPersona) REFERENCES Espectador(IdPersona)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE ComprarEspectador 
ADD CONSTRAINT FK_Alimento_Comprar FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento)
ON DELETE RESTRICT
ON UPDATE CASCADE;

COMMENT ON TABLE ComprarEspectador IS 'Tabla que registra las compras de alimentos realizadas por los espectadores.';

COMMENT ON COLUMN ComprarEspectador.IdPersona IS 'Identificador del espectador que realiza la compra.';
COMMENT ON COLUMN ComprarEspectador.IdAlimento IS 'Identificador del alimento adquirido por el espectador.';
COMMENT ON COLUMN ComprarEspectador.MetodoDePago IS 'Método de pago utilizado: Tarjeta, Efectivo o Transferencia.';
COMMENT ON COLUMN ComprarEspectador.Cantidad IS 'Cantidad total del alimento adquirido por el espectador.';

COMMENT ON CONSTRAINT PK_ComprarEspectador ON ComprarEspectador IS 'Llave primaria compuesta por IdPersona e IdAlimento.';
COMMENT ON CONSTRAINT FK_Espectador_Comprar ON ComprarEspectador IS 'Llave foránea que relaciona la compra con el espectador correspondiente. No permite eliminar un espectador si tiene compras registradas';
COMMENT ON CONSTRAINT FK_Alimento_Comprar ON ComprarEspectador IS 'Llave foránea que vincula el alimento con la compra. No permite eliminar un alimento si está asociado a una compra.';
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
ADD CONSTRAINT FK_Participante_Comprar FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE ComprarParticipanteUNAM 
ADD CONSTRAINT FK_Alimento_Comprar_Participante FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento)
ON DELETE RESTRICT
ON UPDATE CASCADE;

COMMENT ON TABLE ComprarParticipanteUNAM IS 'Tabla que registra las compras de alimentos realizadas por los participantes de la UNAM.';

COMMENT ON COLUMN ComprarParticipanteUNAM.IdPersona IS 'Identificador del participante de la UNAM que realiza la compra.';
COMMENT ON COLUMN ComprarParticipanteUNAM.IdAlimento IS 'Identificador del alimento adquirido por el participante.';
COMMENT ON COLUMN ComprarParticipanteUNAM.MetodoDePago IS 'Método de pago utilizado: Tarjeta, Efectivo o Transferencia.';
COMMENT ON COLUMN ComprarParticipanteUNAM.Cantidad IS 'Cantidad total de alimento comprada por el participante.';

COMMENT ON CONSTRAINT PK_ComprarParticipanteUNAM ON ComprarParticipanteUNAM IS 'Llave primaria compuesta por IdPersona e IdAlimento.';
COMMENT ON CONSTRAINT FK_Participante_Comprar ON ComprarParticipanteUNAM IS 'Llave foránea que vincula la compra con el participante correspondiente. No permite eliminar un participante si tiene compras registradas';
COMMENT ON CONSTRAINT FK_Alimento_Comprar_Participante ON ComprarParticipanteUNAM IS 'Llave foránea que vincula el alimento con la compra. No permite eliminar un alimento si está asociado a una compra.';


-----------Relaciones extra --------------------------------

-- ========
-- EncargadoInscribirParticipante (Va después de EncargadoRegistro y ParticipanteUNAM)
-- =======

CREATE TABLE EncargadoInscribirParticipante (
    IdPersona_encargado INTEGER NOT NULL, 
    IdPersona_participante INTEGER NOT NULL, 
    Fecha DATE NOT NULL
);

ALTER TABLE EncargadoInscribirParticipante 
ADD CONSTRAINT fk_encargado_inscribir_participante_encargado FOREIGN KEY (IdPersona_encargado) REFERENCES EncargadoRegistro(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_encargado_inscribir_participante_participante FOREIGN KEY (IdPersona_participante) REFERENCES ParticipanteUNAM(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE EncargadoInscribirParticipante IS 'Tabla que registra las inscripciones realizadas por los encargados a los participantes, incluyendo la fecha en que se efectuó la inscripción.';
COMMENT ON COLUMN EncargadoInscribirParticipante.IdPersona_encargado IS 'Identificador del encargado de registro que inscribe al participante (llave foránea hacia EncargadoRegistro).';
COMMENT ON COLUMN EncargadoInscribirParticipante.IdPersona_participante IS 'Identificador del participante inscrito (llave foránea hacia ParticipanteUNAM).';
COMMENT ON COLUMN EncargadoInscribirParticipante.Fecha IS 'Fecha en la que el encargado realizó la inscripción del participante.';

COMMENT ON CONSTRAINT fk_encargado_inscribir_participante_encargado ON EncargadoInscribirParticipante IS 'Llave foránea que referencia al encargado de registro que realiza la inscripción, con política ON DELETE RESTRICT ON UPDATE CASCADE.';
COMMENT ON CONSTRAINT fk_encargado_inscribir_participante_participante ON EncargadoInscribirParticipante IS 'Llave foránea que referencia al participante inscrito, con política ON DELETE RESTRICT ON UPDATE CASCADE.';

-- ========
-- ParticipanteInscribirEvento
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
ADD CONSTRAINT FK_InscribirEvento_Edicion FOREIGN KEY (Edicion) REFERENCES Evento(Edicion)
ON DELETE CASCADE
ON UPDATE CASCADE;


ALTER TABLE ParticipanteInscribirEvento 
ADD CONSTRAINT FK_InscribirEvento_Participante FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona)
ON DELETE CASCADE
ON UPDATE CASCADE;

COMMENT ON TABLE ParticipanteInscribirEvento IS 'Tabla que registra la inscripción de participantes de la UNAM a las distintas ediciones de los eventos.';

COMMENT ON COLUMN ParticipanteInscribirEvento.Edicion IS 'Número o identificador de la edición del evento en la que se inscribe el participante.';
COMMENT ON COLUMN ParticipanteInscribirEvento.IdPersona IS 'Identificador del participante de la UNAM inscrito en el evento.';
COMMENT ON COLUMN ParticipanteInscribirEvento.Fecha IS 'Fecha en que el participante realizó su inscripción al evento.';
COMMENT ON COLUMN ParticipanteInscribirEvento.Costo IS 'Costo total de inscripción pagado por el participante.';

COMMENT ON CONSTRAINT PK_ParticipanteInscribirEvento ON ParticipanteInscribirEvento IS 'Llave primaria compuesta por Edicion e IdPersona que garantiza que un participante no se inscriba dos veces al mismo evento.';
COMMENT ON CONSTRAINT FK_InscribirEvento_Edicion ON ParticipanteInscribirEvento IS 'Llave foránea que vincula la inscripción con la edición correspondiente del evento. Si la edición se elimina, también se eliminan las inscripciones asociadas.';
COMMENT ON CONSTRAINT FK_InscribirEvento_Participante ON ParticipanteInscribirEvento IS 'Llave foránea que vincula la inscripción con el participante. Si el participante se elimina, también se eliminan sus registros de inscripción.';


-- ========
-- Asistir
-- ========
CREATE TABLE Asistir (
    Edicion INTEGER NOT NULL,
    IdPersona INTEGER NOT NULL
);

ALTER TABLE Asistir 
ADD CONSTRAINT PK_Asistir PRIMARY KEY (Edicion, IdPersona);

ALTER TABLE Asistir 
ADD CONSTRAINT FK_Asistir_Edicion FOREIGN KEY (Edicion) REFERENCES Evento(Edicion)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Asistir 
ADD CONSTRAINT FK_Asistir_Espectador 
FOREIGN KEY (IdPersona) REFERENCES Espectador(IdPersona)
ON DELETE CASCADE
ON UPDATE CASCADE;

COMMENT ON TABLE Asistir IS 'Tabla que registra la asistencia de los espectadores a las distintas ediciones de los eventos.';

COMMENT ON COLUMN Asistir.Edicion IS 'Número o identificador de la edición del evento al que asiste el espectador';
COMMENT ON COLUMN Asistir.IdPersona IS 'Identificador del espectador que asiste al evento.';

COMMENT ON CONSTRAINT PK_Asistir ON Asistir IS 'Llave primaria compuesta por Edicion e IdPersona que evita registros duplicados de asistencia.';
COMMENT ON CONSTRAINT FK_Asistir_Edicion ON Asistir IS 'Llave foránea que vincula la asistencia con la edición correspondiente del evento. Si el evento se elimina, también se eliminan los registros de asistencia asociados.';
COMMENT ON CONSTRAINT FK_Asistir_Espectador ON Asistir IS 'Llave foránea que vincula la asistencia con el espectador correspondiente. Si el espectador se elimina, también se eliminan sus registros de asistencia.';



--------------- JUEGO 

-- ========
-- CuentaPokemon
-- =======

CREATE TABLE CuentaPokemonGo (
    IdPersona INTEGER NOT NULL,
    CodigoDeEntrenador INTEGER NOT NULL UNIQUE ,
    Equipo VARCHAR(20) NOT NULL,
    Nivel SMALLINT NOT NULL CHECK (Nivel >= 1),
    NombreDeUsuario VARCHAR(30) NOT NULL UNIQUE
);


ALTER TABLE CuentaPokemonGo ADD CONSTRAINT pk_cuenta_pokemon_go PRIMARY KEY (IdPersona, CodigoDeEntrenador);

ALTER TABLE CuentaPokemonGo ADD CONSTRAINT fk_cuenta_pokemon_go_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

COMMENT ON TABLE CuentaPokemonGo IS 'Tabla que almacena la información de las cuentas de Pokémon Go de los participantes.';
COMMENT ON COLUMN CuentaPokemonGo.IdPersona IS 'Identificador único del participante UNAM propietario de la cuenta de Pokémon Go.';
COMMENT ON COLUMN CuentaPokemonGo.CodigoDeEntrenador IS 'Código de entrenador de la cuenta de Pokémon Go.';
COMMENT ON COLUMN CuentaPokemonGo.Equipo IS 'Equipo al que pertenece la cuenta de Pokémon Go.';
COMMENT ON COLUMN CuentaPokemonGo.Nivel IS 'Nivel de la cuenta de Pokémon Go.';
COMMENT ON COLUMN CuentaPokemonGo.NombreDeUsuario IS 'Nombre de usuario de la cuenta de Pokémon Go.';
COMMENT ON CONSTRAINT pk_cuenta_pokemon_go ON CuentaPokemonGo IS 'Restricción de entidad para la tabla CuentaPokemonGo.';
COMMENT ON CONSTRAINT fk_cuenta_pokemon_go_participante_unam ON CuentaPokemonGo IS 'Restricción referencial que vincula CuentaPokemonGo con ParticipanteUNAM.';

-- ========
-- Pokemon
-- =======
CREATE TABLE Pokemon (
    IdPokemon INTEGER NOT NULL UNIQUE ,
    IdPersona INTEGER NOT NULL,
    CodigoDeEntrenador INTEGER NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Sexo VARCHAR(10) NOT NULL CHECK (Sexo IN ('M', 'H', 'Otro')),
    Peso REAL NOT NULL CHECK (Peso > 0),
    PuntosDeCombate INTEGER NOT NULL CHECK (PuntosDeCombate >= 0),
    Shiny BOOLEAN NOT NULL,
    Tipo VARCHAR(20) NOT NULL,
    Especie VARCHAR(20) NOT NULL
);

ALTER TABLE Pokemon ADD CONSTRAINT pk_pokemon PRIMARY KEY (IdPokemon);

ALTER TABLE Pokemon ADD CONSTRAINT fk_pokemon_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador)
    REFERENCES CuentaPokemonGo (IdPersona, CodigoDeEntrenador);

COMMENT ON TABLE Pokemon IS 'Tabla que almacena la información de los pokémones';
COMMENT ON COLUMN Pokemon.IdPokemon IS 'Identificador único del pokémon.';
COMMENT ON COLUMN Pokemon.IdPersona IS 'Identificador de la persona que posee el pokémon.';
COMMENT ON COLUMN Pokemon.CodigoDeEntrenador IS 'Código de entrenador de la cuenta a la que pertenece el pokémon.';
COMMENT ON COLUMN Pokemon.Nombre IS 'Nombre del pokémon.';
COMMENT ON COLUMN Pokemon.Sexo IS 'Sexo del pokémon.';
COMMENT ON COLUMN Pokemon.Peso IS 'Peso del pokémon.';
COMMENT ON COLUMN Pokemon.PuntosDeCombate IS 'Puntos de combate del pokémon.';
COMMENT ON COLUMN Pokemon.Shiny IS 'Indica si el pokémon es shiny o no.';
COMMENT ON COLUMN Pokemon.Tipo IS 'Tipo del pokémon.';
COMMENT ON COLUMN Pokemon.Especie IS 'Especie del pokémon.';
COMMENT ON CONSTRAINT pk_pokemon ON Pokemon IS 'Restricción de entidad para la tabla Pokemon.';
COMMENT ON CONSTRAINT fk_pokemon_cuenta_pokemon_go ON Pokemon IS 'Restricción referencial que vincula Pokemon con CuentaPokemonGo.';

------------- TORNEOS ------------


-- ========
-- TorneoCapturaShinys 
-- ========
CREATE TABLE TorneoCapturaShinys (
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL UNIQUE ,
    IdPersona INTEGER,
    CantidadAPremiar REAL DEFAULT 500.0
);
   
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT pk_torneo_captura_shinys PRIMARY KEY (Edicion, IdTorneo);
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT fk_torneo_captura_shinys_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT fk_torneo_captura_shinys_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

COMMENT ON TABLE TorneoCapturaShinys IS 'Tabla que almacena la información de los torneos de captura de pokémones shiny.';
COMMENT ON COLUMN TorneoCapturaShinys.Edicion IS 'Edición del torneo de captura de pokémones shiny.';
COMMENT ON COLUMN TorneoCapturaShinys.IdTorneo IS 'Identificador único del torneo de captura de pokémones shiny.';
COMMENT ON COLUMN TorneoCapturaShinys.IdPersona IS 'Identificador único del participante UNAM que ganó el torneo.';
COMMENT ON COLUMN TorneoCapturaShinys.CantidadAPremiar IS 'Cantidad en dinero a premiar al ganador del torneo.';
COMMENT ON CONSTRAINT pk_torneo_captura_shinys ON TorneoCapturaShinys IS 'Restricción de entidad para la tabla TorneoCapturaShinys.';
COMMENT ON CONSTRAINT fk_torneo_captura_shinys_evento ON TorneoCapturaShinys IS 'Restricción referencial que vincula TorneoCapturaShinys con Evento.';
COMMENT ON CONSTRAINT fk_torneo_captura_shinys_participante_unam ON TorneoCapturaShinys IS 'Restricción referencial que vincula TorneoCapturaShinys con ParticipanteUNAM.';


-- ========
-- TorneoDistanciaRecorrida
-- ========
CREATE TABLE TorneoDistanciaRecorrida (
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL UNIQUE ,
    IdPersona INTEGER,
    CantidadAPremiar REAL DEFAULT 500.0
);

ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT pk_torneo_distancia_recorrida PRIMARY KEY (Edicion, IdTorneo);
ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT fk_torneo_distancia_recorrida_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);
ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT fk_torneo_distancia_recorrida_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

COMMENT ON TABLE TorneoDistanciaRecorrida IS 'Tabla que almacena la información de los torneos de distancia recorrida.';
COMMENT ON COLUMN TorneoDistanciaRecorrida.Edicion IS 'Edición del torneo de distancia recorrida.';
COMMENT ON COLUMN TorneoDistanciaRecorrida.IdTorneo IS 'Identificador único del torneo de distancia recorrida.';
COMMENT ON COLUMN TorneoDistanciaRecorrida.IdPersona IS 'Identificador único del participante UNAM que ganó el torneo.';
COMMENT ON COLUMN TorneoDistanciaRecorrida.CantidadAPremiar IS 'Cantidad en dinero a premiar al ganador del torneo.';
COMMENT ON CONSTRAINT pk_torneo_distancia_recorrida ON TorneoDistanciaRecorrida IS 'Restricción de entidad para la tabla TorneoDistanciaRecorrida.';
COMMENT ON CONSTRAINT fk_torneo_distancia_recorrida_evento ON TorneoDistanciaRecorrida IS 'Restricción referencial que vincula TorneoDistanciaRecorrida con Evento.';
COMMENT ON CONSTRAINT fk_torneo_distancia_recorrida_participante_unam ON TorneoDistanciaRecorrida IS 'Restricción referencial que vincula TorneoDistanciaRecorrida con ParticipanteUNAM.';

-- ========
-- TorneoPelea 
-- =======
CREATE TABLE TorneoPelea (
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL UNIQUE ,
    IdPersona INTEGER,
    CantidadAPremiar REAL DEFAULT 500.0
);
ALTER TABLE TorneoPelea ADD CONSTRAINT pk_torneo_pelea PRIMARY KEY (Edicion, IdTorneo);
ALTER TABLE TorneoPelea ADD CONSTRAINT fk_torneo_pelea_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion);
ALTER TABLE TorneoPelea ADD CONSTRAINT fk_torneo_pelea_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona);

COMMENT ON TABLE TorneoPelea IS 'Tabla que almacena la información de los torneos de pelea.';
COMMENT ON COLUMN TorneoPelea.Edicion IS 'Edición del torneo de pelea.';
COMMENT ON COLUMN TorneoPelea.IdTorneo IS 'Identificador único del torneo de pelea.';
COMMENT ON COLUMN TorneoPelea.IdPersona IS 'Identificador único del participante UNAM que ganó el torneo.';
COMMENT ON COLUMN TorneoPelea.CantidadAPremiar IS 'Cantidad en dinero a premiar al ganador del torneo.';
COMMENT ON CONSTRAINT pk_torneo_pelea ON TorneoPelea IS 'Restricción de entidad para la tabla TorneoPelea.';
COMMENT ON CONSTRAINT fk_torneo_pelea_evento ON TorneoPelea IS 'Restricción referencial que vincula TorneoPelea con Evento.';
COMMENT ON CONSTRAINT fk_torneo_pelea_participante_unam ON TorneoPelea IS 'Restricción referencial que vincula TorneoPelea con ParticipanteUNAM.';


-- ========
-- PeleaTorneo 
-- =======
CREATE TABLE PeleaTorneo (
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL,
    NumeroPelea INTEGER NOT NULL  UNIQUE,
    IdPersona INTEGER,
    CodigoDeEntrenador INTEGER NOT NULL,
    Fecha DATE NOT NULL,
    Fase INTEGER NOT NULL
);
ALTER TABLE PeleaTorneo ADD CONSTRAINT pk_pelea_torneo PRIMARY KEY (Edicion, IdTorneo, NumeroPelea);
ALTER TABLE PeleaTorneo ADD CONSTRAINT fk_pelea_torneo_torneo FOREIGN KEY (Edicion, IdTorneo) REFERENCES TorneoPelea(Edicion, IdTorneo);
ALTER TABLE PeleaTorneo ADD CONSTRAINT fk_pelea_torneo_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador);

COMMENT ON TABLE PeleaTorneo IS 'Tabla que almacena la información de las peleas en los torneos.';
COMMENT ON COLUMN PeleaTorneo.Edicion IS 'Edición del torneo de pelea.';
COMMENT ON COLUMN PeleaTorneo.IdTorneo IS 'Identificador único del torneo de pelea.';
COMMENT ON COLUMN PeleaTorneo.NumeroPelea IS 'Número de la pelea dentro del torneo.';
COMMENT ON COLUMN PeleaTorneo.IdPersona IS 'Identificador único del participante UNAM en la pelea.';
COMMENT ON COLUMN PeleaTorneo.CodigoDeEntrenador IS 'Código de entrenador de la cuenta de Pokémon Go del participante.';
COMMENT ON COLUMN PeleaTorneo.Fecha IS 'Fecha en la que se llevó a cabo la pelea.';
COMMENT ON COLUMN PeleaTorneo.Fase IS 'Fase del torneo en la que se realizó la pelea.';
COMMENT ON CONSTRAINT pk_pelea_torneo ON PeleaTorneo IS 'Restricción de entidad para la tabla PeleaTorneo.';
COMMENT ON CONSTRAINT fk_pelea_torneo_torneo ON PeleaTorneo IS 'Restricción referencial que vincula PeleaTorneo con TorneoPelea.';
COMMENT ON CONSTRAINT fk_pelea_torneo_cuenta_pokemon_go ON PeleaTorneo IS 'Restricción referencial que vincula PeleaTorneo con CuentaPokemonGo.';

-- ========
-- DistanciaRecorrida
-- ========
CREATE TABLE DistanciaRecorrida (
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL,
    IdDistancia INTEGER NOT NULL UNIQUE ,
    IdPersona INTEGER NOT NULL,
    CodigoDeEntrenador INTEGER NOT NULL,
    Locacion VARCHAR(10) NOT NULL CHECK (Locacion IN ('Universum', 'Entrada', 'Rectoria')),
    Fecha DATE NOT NULL,
    Hora TIMETZ NOT NULL
);

ALTER TABLE DistanciaRecorrida ADD CONSTRAINT pk_distancia_recorrido PRIMARY KEY (Edicion, IdTorneo, IdDistancia);
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT fk_distancia_recorrida_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador);
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT fk_distancia_recorrida_torneo_distancia_recorrida FOREIGN KEY (Edicion, IdTorneo) REFERENCES TorneoDistanciaRecorrida(Edicion, IdTorneo);

COMMENT ON TABLE DistanciaRecorrida IS 'Tabla que almacena la información de las distancias recorridas por los participantes en los torneos.';
COMMENT ON COLUMN DistanciaRecorrida.Edicion IS 'Edición del torneo en la que se registró la distancia recorrida.';
COMMENT ON COLUMN DistanciaRecorrida.IdTorneo IS 'Identificador único del torneo de distancia recorrida.';
COMMENT ON COLUMN DistanciaRecorrida.IdDistancia IS 'Identificador único de la distancia recorrida.';
COMMENT ON COLUMN DistanciaRecorrida.IdPersona IS 'Identificador único del participante que recorrió la distancia.';
COMMENT ON COLUMN DistanciaRecorrida.CodigoDeEntrenador IS 'Código de entrenador de la cuenta de Pokémon Go del participante.';
COMMENT ON COLUMN DistanciaRecorrida.Locacion IS 'Locación donde se registró la distancia recorrida.';
COMMENT ON COLUMN DistanciaRecorrida.Fecha IS 'Fecha en la que se registró la distancia recorrida.';
COMMENT ON COLUMN DistanciaRecorrida.Hora IS 'Hora en la que se registró la distancia recorrida.';
COMMENT ON CONSTRAINT pk_distancia_recorrido ON DistanciaRecorrida IS 'Restricción de entidad para la tabla DistanciaRecorrida.';
COMMENT ON CONSTRAINT fk_distancia_recorrida_cuenta_pokemon_go ON DistanciaRecorrida IS 'Restricción referencial que vincula DistanciaRecorrida con CuentaPokemonGo.';
COMMENT ON CONSTRAINT fk_distancia_recorrida_torneo_distancia_recorrida ON DistanciaRecorrida IS 'Restricción referencial que vincula DistanciaRecorrida con TorneoDistanciaRecorrida.';


-- ========
-- Utilizar 
-- ========
CREATE TABLE Utilizar (
    IdPokemon INTEGER NOT NULL,
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL,
    NumeroPelea INTEGER NOT NULL
);
ALTER TABLE Utilizar ADD CONSTRAINT fk_utilizar_pokemon FOREIGN KEY (IdPokemon) REFERENCES Pokemon(IdPokemon);
ALTER TABLE Utilizar ADD CONSTRAINT fk_utilizar_pelea_torneo FOREIGN KEY (Edicion, IdTorneo, NumeroPelea) REFERENCES PeleaTorneo(Edicion, IdTorneo, NumeroPelea);

COMMENT ON TABLE Utilizar IS 'Tabla que registra qué pokémones fueron utilizados en las peleas de los torneos.';
COMMENT ON COLUMN Utilizar.IdPokemon IS 'Identificador único del pokémon utilizado en la pelea.';
COMMENT ON COLUMN Utilizar.Edicion IS 'Edición del torneo en la que se llevó a cabo la pelea.';
COMMENT ON COLUMN Utilizar.IdTorneo IS 'Identificador único del torneo en el que se llevó a cabo la pelea.';
COMMENT ON COLUMN Utilizar.NumeroPelea IS 'Número de la pelea en la que se utilizó el pokémon.';
COMMENT ON CONSTRAINT fk_utilizar_pokemon ON Utilizar IS 'Restricción referencial que vincula Utilizar con Pokemon.';
COMMENT ON CONSTRAINT fk_utilizar_pelea_torneo ON Utilizar IS 'Restricción referencial que vincula Utilizar con PeleaTorneo.';



-- ========
-- CapturaPokemon
-- ========
CREATE TABLE CapturaPokemon (
    Edicion INTEGER NOT NULL,
    IdTorneo INTEGER NOT NULL,
    IdCaptura INTEGER NOT NULL UNIQUE 
);


ALTER TABLE CapturaPokemon ADD CONSTRAINT pk_captura_pokemon PRIMARY KEY (Edicion, IdTorneo, IdCaptura);
ALTER TABLE CapturaPokemon ADD CONSTRAINT fk_captura_pokemon_torneo_captura_shinys FOREIGN KEY (Edicion, IdTorneo) REFERENCES TorneoCapturaShinys(Edicion, IdTorneo);

COMMENT ON TABLE CapturaPokemon IS 'Tabla que almacena la información de las capturas de pokémones en los torneos.';
COMMENT ON COLUMN CapturaPokemon.Edicion IS 'Edición del torneo en la que se realizó la captura.';
COMMENT ON COLUMN CapturaPokemon.IdTorneo IS 'Identificador único del torneo de captura de pokémones shiny.';
COMMENT ON COLUMN CapturaPokemon.IdCaptura IS 'Identificador único de la captura realizada.';
COMMENT ON CONSTRAINT pk_captura_pokemon ON CapturaPokemon IS 'Restricción de entidad para la tabla CapturaPokemon.';
COMMENT ON CONSTRAINT fk_captura_pokemon_torneo_captura_shinys ON CapturaPokemon IS 'Restricción referencial que vincula CapturaPokemon con TorneoCapturaShinys.';

-- ========
--  Registrar
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

COMMENT ON TABLE Registrar IS 'Tabla que registra las capturas de pokémones por los participantes en los torneos.';
COMMENT ON COLUMN Registrar.IdPokemon IS 'Identificador único del pokémon capturado.';
COMMENT ON COLUMN Registrar.CodigoDeEntrenador IS 'Código de entrenador de la cuenta de Pokémon Go del participante.';
COMMENT ON COLUMN Registrar.IdPersona IS 'Identificador único del participante que realizó la captura.';
COMMENT ON COLUMN Registrar.IdCaptura IS 'Identificador único de la captura realizada.';
COMMENT ON COLUMN Registrar.Edicion IS 'Edición del torneo en la que se realizó la captura.';
COMMENT ON COLUMN Registrar.IdTorneo IS 'Identificador único del torneo de captura de pokémones shiny.';
COMMENT ON COLUMN Registrar.Fecha IS 'Fecha en la que se realizó la captura.';
COMMENT ON COLUMN Registrar.Hora IS 'Hora en la que se realizó la captura.';
COMMENT ON CONSTRAINT fk_registrar_cuenta_pokemon_go ON Registrar IS 'Restricción referencial que vincula Registrar con CuentaPokemonGo.';
COMMENT ON CONSTRAINT fk_registrar_captura_pokemon ON Registrar IS 'Restricción referencial que vincula Registrar con CapturaPokemon.';
COMMENT ON CONSTRAINT fk_registrar_pokemon ON Registrar IS 'Restricción referencial que vincula Registrar con Pokemon.';