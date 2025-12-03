-- ========
--  Evento 
-- =======
CREATE TABLE Evento (
    Edicion INTEGER,
    Fecha DATE
);

ALTER TABLE Evento ADD CONSTRAINT pk_evento PRIMARY KEY (Edicion);

ALTER TABLE Evento ALTER COLUMN Fecha SET NOT NULL;

COMMENT ON TABLE Evento IS 'Tabla que almacena la información de los torneos de pokémon go.';
COMMENT ON COLUMN Evento.Edicion IS 'Número de edición del evento.';
COMMENT ON COLUMN Evento.Fecha IS 'Fecha en la que se lleva a cabo el evento.';
COMMENT ON CONSTRAINT pk_evento ON Evento IS 'Restricción de entidad para la tabla Evento.';

------------------- PERSONAS -------------------
-- ========
--  ParticipanteUNAM
-- ========
CREATE TABLE ParticipanteUNAM (
    IdPersona INTEGER,
    NumeroDeCuenta INTEGER,
    Nombre VARCHAR(20),
    ApellidoMaterno VARCHAR(20),
    ApellidoPaterno VARCHAR(20),
    FechaNacimiento DATE,
    Sexo VARCHAR(10),
    Carrera VARCHAR(20) ,
    Facultad VARCHAR(20)
);

ALTER TABLE ParticipanteUNAM ADD CONSTRAINT pk_ParticipanteUNAM PRIMARY KEY (IdPersona);
ALTER TABLE ParticipanteUNAM ALTER COLUMN NumeroDeCuenta SET NOT NULL;
ALTER TABLE ParticipanteUNAM ADD CONSTRAINT UQ_NumeroDeCuenta UNIQUE (NumeroDeCuenta);
ALTER TABLE ParticipanteUNAM ADD CONSTRAINT long_NumeroDeCuenta CHECK (NumeroDeCuenta BETWEEN 100000000 AND 999999999);
ALTER TABLE ParticipanteUNAM ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE ParticipanteUNAM ALTER COLUMN ApellidoMaterno SET NOT NULL;
ALTER TABLE ParticipanteUNAM ALTER COLUMN ApellidoPaterno SET NOT NULL;
ALTER TABLE ParticipanteUNAM ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE ParticipanteUNAM ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE ParticipanteUNAM ALTER COLUMN Carrera SET NOT NULL;
ALTER TABLE ParticipanteUNAM ALTER COLUMN Facultad SET NOT NULL;
ALTER TABLE ParticipanteUNAM ALTER COLUMN IdPersona SET NOT NULL;

ALTER TABLE ParticipanteUNAM ALTER COLUMN Nombre TYPE VARCHAR(100);
ALTER TABLE ParticipanteUNAM ALTER COLUMN ApellidoMaterno TYPE VARCHAR(100);
ALTER TABLE ParticipanteUNAM ALTER COLUMN ApellidoPaterno TYPE VARCHAR(100);
ALTER TABLE ParticipanteUNAM ALTER COLUMN Carrera TYPE VARCHAR(100);
ALTER TABLE ParticipanteUNAM ALTER COLUMN Facultad TYPE VARCHAR(100);

ALTER TABLE ParticipanteUNAM ADD CONSTRAINT CK_Sexo CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE ParticipanteUNAM ADD CONSTRAINT CK_FechaNacimiento CHECK (FechaNacimiento <= CURRENT_DATE);
ALTER TABLE ParticipanteUNAM ADD CONSTRAINT CK_EdadMaxima CHECK (FechaNacimiento >= CURRENT_DATE - INTERVAL '100 years');
ALTER TABLE ParticipanteUNAM ADD CONSTRAINT CK_Nombre CHECK (Nombre <> '');
ALTER TABLE ParticipanteUNAM ADD CONSTRAINT CK_ApellidoMaterno CHECK (ApellidoMaterno <> '');
ALTER TABLE ParticipanteUNAM ADD CONSTRAINT CK_ApellidoPaterno CHECK (ApellidoPaterno <> '');

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

COMMENT ON CONSTRAINT pk_ParticipanteUNAM ON ParticipanteUNAM IS 'Llave primaria que identifica de forma única a cada participante.';
COMMENT ON CONSTRAINT CK_Sexo ON ParticipanteUNAM IS 'Restricción CHECK que valida que el valor de Sexo sea M, H u Otro.';
COMMENT ON CONSTRAINT UQ_NumeroDeCuenta ON ParticipanteUNAM IS 'Restricción UNIQUE que asegura que el número de cuenta de la UNAM no se repita entre participantes.';
COMMENT ON CONSTRAINT long_NumeroDeCuenta ON ParticipanteUNAM IS 'Restricción CHECK que valida que el número de cuenta tenga exactamente 9 dígitos.';
COMMENT ON CONSTRAINT CK_FechaNacimiento ON ParticipanteUNAM IS 'Restricción CHECK que valida que la fecha de nacimiento no sea futura.';
COMMENT ON CONSTRAINT CK_EdadMaxima ON ParticipanteUNAM IS 'Restricción CHECK que valida que la edad del participante no exceda los 100 años.';
COMMENT ON CONSTRAINT CK_Nombre ON ParticipanteUNAM IS 'Restricción CHECK que valida que el nombre no esté vacío.';
COMMENT ON CONSTRAINT CK_ApellidoMaterno ON ParticipanteUNAM IS 'Restricción CHECK que valida que el apellido materno no esté vacío.';
COMMENT ON CONSTRAINT CK_ApellidoPaterno ON ParticipanteUNAM IS 'Restricción CHECK que valida que el apellido paterno no esté vacío.';

CREATE SEQUENCE seq_participanteunam
    START 1
    INCREMENT 1
    OWNED BY ParticipanteUNAM.IdPersona;

ALTER TABLE ParticipanteUNAM
ALTER COLUMN IdPersona SET DEFAULT nextval('seq_participanteunam');


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


ALTER TABLE EncargadoRegistro ADD CONSTRAINT pk_encargado_registro PRIMARY KEY (IdPersona);
ALTER TABLE EncargadoRegistro ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN ApellidoMaterno SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN ApellidoPaterno SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN FechaDeNacimiento SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN Colonia SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN Ciudad SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN CodigoPostal SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN NumInterior SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN NumExterior SET NOT NULL;
ALTER TABLE EncargadoRegistro ALTER COLUMN EsJugador SET NOT NULL;

ALTER TABLE EncargadoRegistro ALTER COLUMN Nombre TYPE VARCHAR(100);
ALTER TABLE EncargadoRegistro ALTER COLUMN ApellidoMaterno TYPE VARCHAR(100);
ALTER TABLE EncargadoRegistro ALTER COLUMN ApellidoPaterno TYPE VARCHAR(100);
ALTER TABLE EncargadoRegistro ALTER COLUMN Calle TYPE VARCHAR(100);
ALTER TABLE EncargadoRegistro ALTER COLUMN Colonia TYPE VARCHAR(100);
ALTER TABLE EncargadoRegistro ALTER COLUMN Ciudad TYPE VARCHAR(100);

ALTER TABLE EncargadoRegistro ADD CONSTRAINT CK_Sexo_EncargadoRegistro CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE EncargadoRegistro ADD CONSTRAINT CK_CodigoPostal CHECK (CodigoPostal BETWEEN 10000 AND 99999);
ALTER TABLE EncargadoRegistro ADD CONSTRAINT CK_NumInterior CHECK (NumInterior >= 0);
ALTER TABLE EncargadoRegistro ADD CONSTRAINT CK_NumExterior CHECK (NumExterior > 0);
ALTER TABLE EncargadoRegistro ADD CONSTRAINT CK_FechaDeNacimiento_EncargadoRegistro CHECK (FechaDeNacimiento <= CURRENT_DATE);
ALTER TABLE EncargadoRegistro ADD CONSTRAINT CK_EdadMaxima_EncargadoRegistro CHECK (FechaDeNacimiento >= CURRENT_DATE - INTERVAL '100 years');
ALTER TABLE EncargadoRegistro ADD CONSTRAINT CK_Nombre_EncargadoRegistro CHECK (Nombre <> '');
ALTER TABLE EncargadoRegistro ADD CONSTRAINT CK_ApellidoMaterno_EncargadoRegistro CHECK (ApellidoMaterno <> '');
ALTER TABLE EncargadoRegistro ADD CONSTRAINT CK_ApellidoPaterno_EncargadoRegistro CHECK (ApellidoPaterno <> '');
ALTER TABLE EncargadoRegistro ADD CONSTRAINT CK_Calle_EncargadoRegistro CHECK (Calle <> '');
ALTER TABLE EncargadoRegistro ADD CONSTRAINT CK_Colonia_EncargadoRegistro CHECK (Colonia <> '');
ALTER TABLE EncargadoRegistro ADD CONSTRAINT CK_Ciudad_EncargadoRegistro CHECK (Ciudad <> '');


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
COMMENT ON CONSTRAINT CK_Sexo_EncargadoRegistro ON EncargadoRegistro IS 'Restricción CHECK que valida que el valor de Sexo sea M, H u Otro.';
COMMENT ON CONSTRAINT CK_CodigoPostal ON EncargadoRegistro IS 'Restricción CHECK que valida que el Código Postal tenga exactamente 5 dígitos.';
COMMENT ON CONSTRAINT CK_NumInterior ON EncargadoRegistro IS 'Restricción CHECK que valida que el Número Interior sea mayor o igual a 0.';
COMMENT ON CONSTRAINT CK_NumExterior ON EncargadoRegistro IS 'Restricción CHECK que valida que el Número Exterior sea mayor a 0.';
COMMENT ON CONSTRAINT CK_FechaDeNacimiento_EncargadoRegistro ON EncargadoRegistro IS 'Restricción CHECK que valida que la fecha de nacimiento no sea futura.';
COMMENT ON CONSTRAINT CK_EdadMaxima_EncargadoRegistro ON EncargadoRegistro IS 'Restricción CHECK que valida que la edad del encargado de registro no exceda los 100 años.';
COMMENT ON CONSTRAINT CK_Nombre_EncargadoRegistro ON EncargadoRegistro IS 'Restricción CHECK que valida que el nombre no esté vacío.';
COMMENT ON CONSTRAINT CK_ApellidoMaterno_EncargadoRegistro ON EncargadoRegistro IS 'Restricción CHECK que valida que el apellido materno no esté vacío.';
COMMENT ON CONSTRAINT CK_ApellidoPaterno_EncargadoRegistro ON EncargadoRegistro IS 'Restricción CHECK que valida que el apellido paterno no esté vacío.';
COMMENT ON CONSTRAINT CK_Calle_EncargadoRegistro ON EncargadoRegistro IS 'Restricción CHECK que valida que la calle no esté vacía.';
COMMENT ON CONSTRAINT CK_Colonia_EncargadoRegistro ON EncargadoRegistro IS 'Restricción CHECK que valida que la colonia no esté vacía.';
COMMENT ON CONSTRAINT CK_Ciudad_EncargadoRegistro ON EncargadoRegistro IS 'Restricción CHECK que valida que la ciudad no esté vacía.';

ALTER TABLE EncargadoRegistro RENAME COLUMN FechaDeNacimiento TO FechaNacimiento;

CREATE SEQUENCE encargadoRegistro_idpersona_seq OWNED BY EncargadoRegistro.IdPersona;
ALTER TABLE EncargadoRegistro ALTER COLUMN IdPersona SET DEFAULT nextval('encargadoRegistro_idpersona_seq');
COMMENT ON SEQUENCE encargadoRegistro_idpersona_seq IS 'Secuencia para generar identificadores únicos para la tabla EncargadoRegistro.';

ALTER TABLE EncargadoRegistro
DROP CONSTRAINT IF EXISTS CK_CodigoPostal;

ALTER TABLE EncargadoRegistro
ADD CONSTRAINT CK_CodigoPostal
CHECK (CodigoPostal BETWEEN 1000 AND 99999);
COMMENT ON CONSTRAINT CK_CodigoPostal ON EncargadoRegistro IS 'Restricción CHECK que valida que el Código Postal tenga entre 4 y 5 dígitos.';


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
    Calle VARCHAR (20) ,
    Colonia VARCHAR (20),
    Ciudad VARCHAR (20),
    CodigoPostal INTEGER,
    NumInterior INTEGER,
    NumExterior INTEGER,
    Ubicacion VARCHAR (20) 
);
ALTER TABLE Vendedor ADD CONSTRAINT pk_vendedor PRIMARY KEY (IdPersona);

ALTER TABLE Vendedor ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN ApellidoMaterno SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN ApellidoPaterno SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN Colonia SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN Ciudad SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN CodigoPostal SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN NumExterior SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN NumInterior SET NOT NULL;
ALTER TABLE Vendedor ALTER COLUMN Ubicacion SET NOT NULL;

ALTER TABLE Vendedor ALTER COLUMN Nombre TYPE VARCHAR(100);
ALTER TABLE Vendedor ALTER COLUMN ApellidoMaterno TYPE VARCHAR(100);
ALTER TABLE Vendedor ALTER COLUMN ApellidoPaterno TYPE VARCHAR(100);
ALTER TABLE Vendedor ALTER COLUMN Calle TYPE VARCHAR(100);
ALTER TABLE Vendedor ALTER COLUMN Colonia TYPE VARCHAR(100);
ALTER TABLE Vendedor ALTER COLUMN Ciudad TYPE VARCHAR(100);
ALTER TABLE Vendedor ALTER COLUMN Ubicacion TYPE VARCHAR(100);

ALTER TABLE Vendedor ADD CONSTRAINT CK_Sexo_Vendedor CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE Vendedor ADD CONSTRAINT CK_CodigoPostal_Vendedor CHECK (CodigoPostal BETWEEN 10000 AND 99999);
ALTER TABLE Vendedor ADD CONSTRAINT CK_NumInterior_Vendedor CHECK (NumInterior >= 0);
ALTER TABLE Vendedor ADD CONSTRAINT CK_NumExterior_Vendedor CHECK (NumExterior > 0);
ALTER TABLE Vendedor ADD CONSTRAINT CK_FechaNacimiento_Vendedor CHECK (FechaNacimiento <= CURRENT_DATE);
ALTER TABLE Vendedor ADD CONSTRAINT CK_EdadMaxima_Vendedor CHECK (FechaNacimiento >= CURRENT_DATE - INTERVAL '100 years');
ALTER TABLE Vendedor ADD CONSTRAINT CK_Nombre_Vendedor CHECK (Nombre <> '');
ALTER TABLE Vendedor ADD CONSTRAINT CK_ApellidoMaterno_Vendedor CHECK (ApellidoMaterno <> '');
ALTER TABLE Vendedor ADD CONSTRAINT CK_ApellidoPaterno_Vendedor CHECK (ApellidoPaterno <> '');
ALTER TABLE Vendedor ADD CONSTRAINT CK_Calle_Vendedor CHECK (Calle <> '');
ALTER TABLE Vendedor ADD CONSTRAINT CK_Colonia_Vendedor CHECK (Colonia <> '');
ALTER TABLE Vendedor ADD CONSTRAINT CK_Ciudad_Vendedor CHECK (Ciudad <> '');



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
COMMENT ON CONSTRAINT CK_Sexo_Vendedor ON Vendedor IS 'Restricción CHECK que valida que el valor de Sexo sea M, H u Otro.';
COMMENT ON CONSTRAINT CK_CodigoPostal_Vendedor ON Vendedor IS 'Restricción CHECK que valida que el Código Postal tenga exactamente 5 dígitos.';
COMMENT ON CONSTRAINT CK_NumInterior_Vendedor ON Vendedor IS 'Restricción CHECK que valida que el Número Interior sea mayor o igual a 0.';
COMMENT ON CONSTRAINT CK_NumExterior_Vendedor ON Vendedor IS 'Restricción CHECK que valida que el Número Exterior sea mayor a 0.';
COMMENT ON CONSTRAINT CK_FechaNacimiento_Vendedor ON Vendedor IS 'Restricción CHECK que valida que la fecha de nacimiento no sea futura.';
COMMENT ON CONSTRAINT CK_EdadMaxima_Vendedor ON Vendedor IS 'Restricción CHECK que valida que la edad del vendedor no exceda los 100 años.';
COMMENT ON CONSTRAINT CK_Nombre_Vendedor ON Vendedor IS 'Restricción CHECK que valida que el nombre no esté vacío.';
COMMENT ON CONSTRAINT CK_ApellidoMaterno_Vendedor ON Vendedor IS 'Restricción CHECK que valida que el apellido materno no esté vacío.';
COMMENT ON CONSTRAINT CK_ApellidoPaterno_Vendedor ON Vendedor IS 'Restricción CHECK que valida que el apellido paterno no esté vacío.';
COMMENT ON CONSTRAINT CK_Calle_Vendedor ON Vendedor IS 'Restricción CHECK que valida que la calle no esté vacía.';
COMMENT ON CONSTRAINT CK_Colonia_Vendedor ON Vendedor IS 'Restricción CHECK que valida que la colonia no esté vacía.';
COMMENT ON CONSTRAINT CK_Ciudad_Vendedor ON Vendedor IS 'Restricción CHECK que valida que la ciudad no esté vacía.';

COMMENT ON CONSTRAINT pk_vendedor ON Vendedor IS 'Restricción de entidad para la tabla Vendedor.';

CREATE SEQUENCE vendedor_idpersona_seq OWNED BY Vendedor.IdPersona;
ALTER TABLE Vendedor ALTER COLUMN IdPersona SET DEFAULT nextval('vendedor_idpersona_seq');
COMMENT ON SEQUENCE vendedor_idpersona_seq IS 'Secuencia para generar identificadores únicos para la tabla Vendedor.';

ALTER TABLE Vendedor
DROP CONSTRAINT IF EXISTS CK_CodigoPostal_Vendedor;

ALTER TABLE Vendedor
ADD CONSTRAINT CK_CodigoPostal_Vendedor
CHECK (CodigoPostal BETWEEN 1000 AND 99999);

COMMENT ON CONSTRAINT CK_CodigoPostal_Vendedor ON Vendedor IS 'Restricción CHECK que valida que el Código Postal tenga entre 4 y 5 dígitos.';

-- ========
-- Cuidador
-- =======
CREATE TABLE Cuidador (
    IdPersona INTEGER,
    Nombre VARCHAR (20),
    ApellidoMaterno VARCHAR (20),
    ApellidoPaterno VARCHAR (20),
    FechaNacimiento DATE ,
    Sexo VARCHAR (10) ,
    Calle VARCHAR (20),
    Colonia VARCHAR (20),
    Ciudad VARCHAR (20),
    CodigoPostal INTEGER,
    NumInterior INTEGER ,
    NumExterior INTEGER,
    Ubicacion VARCHAR (20),
    Horario VARCHAR (10),
    Salario REAL  
);
ALTER TABLE Cuidador ADD CONSTRAINT pk_cuidador PRIMARY KEY (IdPersona);
ALTER TABLE Cuidador ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN ApellidoMaterno SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN ApellidoPaterno SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN Colonia SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN Ciudad SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN CodigoPostal SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN NumExterior SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN NumInterior SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN Ubicacion SET NOT NULL;

ALTER TABLE Cuidador ALTER COLUMN Nombre TYPE VARCHAR(100);
ALTER TABLE Cuidador ALTER COLUMN ApellidoMaterno TYPE VARCHAR(100);
ALTER TABLE Cuidador ALTER COLUMN ApellidoPaterno TYPE VARCHAR(100);
ALTER TABLE Cuidador ALTER COLUMN Calle TYPE VARCHAR(100);
ALTER TABLE Cuidador ALTER COLUMN Colonia TYPE VARCHAR(100);
ALTER TABLE Cuidador ALTER COLUMN Ciudad TYPE VARCHAR(100);
ALTER TABLE Cuidador ALTER COLUMN Ubicacion TYPE VARCHAR(100);

ALTER TABLE Cuidador ADD CONSTRAINT CK_Sexo_Cuidador CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE Cuidador ADD CONSTRAINT CK_CodigoPostal_Cuidador CHECK (CodigoPostal >= 10000 AND CodigoPostal < 100000);
ALTER TABLE Cuidador ADD CONSTRAINT CK_NumInterior_Cuidador CHECK (NumInterior >= 0);
ALTER TABLE Cuidador ADD CONSTRAINT CK_NumExterior_Cuidador CHECK (NumExterior > 0);
ALTER TABLE Cuidador ADD CONSTRAINT CK_FechaNacimiento_Cuidador CHECK (FechaNacimiento <= CURRENT_DATE);
ALTER TABLE Cuidador ADD CONSTRAINT CK_EdadMaxima_Cuidador CHECK (EXTRACT(YEAR FROM AGE(FechaNacimiento)) <= 100);
ALTER TABLE Cuidador ADD CONSTRAINT CK_Nombre_Cuidador CHECK (Nombre <> '');
ALTER TABLE Cuidador ADD CONSTRAINT CK_ApellidoMaterno_Cuidador CHECK (ApellidoMaterno <> '');
ALTER TABLE Cuidador ADD CONSTRAINT CK_ApellidoPaterno_Cuidador CHECK (ApellidoPaterno <> '');
ALTER TABLE Cuidador ADD CONSTRAINT CK_Calle_Cuidador CHECK (Calle <> '');
ALTER TABLE Cuidador ADD CONSTRAINT CK_Colonia_Cuidador CHECK (Colonia <> '');
ALTER TABLE Cuidador ADD CONSTRAINT CK_Ciudad_Cuidador CHECK (Ciudad <> '');
ALTER TABLE Cuidador ADD CONSTRAINT CK_Salario_Cuidador CHECK (Salario >= 0);
ALTER TABLE Cuidador ADD CONSTRAINT CK_Horario_Cuidador CHECK (Horario IN ('Matutino', 'Vespertino'));

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
COMMENT ON CONSTRAINT CK_Sexo_Cuidador ON Cuidador IS 'Restricción CHECK que valida que el valor de Sexo sea M, H u Otro.';
COMMENT ON CONSTRAINT CK_CodigoPostal_Cuidador ON Cuidador IS 'Restricción CHECK que valida que el Código Postal tenga exactamente 5 dígitos.';
COMMENT ON CONSTRAINT CK_NumInterior_Cuidador ON Cuidador IS 'Restricción CHECK que valida que el Número Interior sea mayor o igual a 0.';
COMMENT ON CONSTRAINT CK_NumExterior_Cuidador ON Cuidador IS 'Restricción CHECK que valida que el Número Exterior sea mayor a 0.';
COMMENT ON CONSTRAINT CK_FechaNacimiento_Cuidador ON Cuidador IS 'Restricción CHECK que valida que la fecha de nacimiento no sea futura.';
COMMENT ON CONSTRAINT CK_EdadMaxima_Cuidador ON Cuidador IS 'Restricción CHECK que valida que la edad del cuidador no exceda los 100 años.';
COMMENT ON CONSTRAINT CK_Nombre_Cuidador ON Cuidador IS 'Restricción CHECK que valida que el nombre no esté vacío.';
COMMENT ON CONSTRAINT CK_ApellidoMaterno_Cuidador ON Cuidador IS 'Restricción CHECK que valida que el apellido materno no esté vacío.';
COMMENT ON CONSTRAINT CK_ApellidoPaterno_Cuidador ON Cuidador IS 'Restricción CHECK que valida que el apellido paterno no esté vacío.';
COMMENT ON CONSTRAINT CK_Calle_Cuidador ON Cuidador IS 'Restricción CHECK que valida que la calle no esté vacía.';
COMMENT ON CONSTRAINT CK_Colonia_Cuidador ON Cuidador IS 'Restricción CHECK que valida que la colonia no esté vacía.';
COMMENT ON CONSTRAINT CK_Ciudad_Cuidador ON Cuidador IS 'Restricción CHECK que valida que la ciudad no esté vacía.';
COMMENT ON CONSTRAINT CK_Salario_Cuidador ON Cuidador IS 'Restricción CHECK que valida que el salario sea mayor o igual a 0.';
COMMENT ON CONSTRAINT CK_Horario_Cuidador ON Cuidador IS 'Restricción CHECK que valida que el horario sea Matutino o Vespertino.';


COMMENT ON CONSTRAINT pk_cuidador ON Cuidador IS 'Restricción de entidad para la tabla Cuidador.';

CREATE SEQUENCE cuidador_idpersona_seq OWNED BY Cuidador.IdPersona;
ALTER TABLE Cuidador ALTER COLUMN IdPersona SET DEFAULT nextval('cuidador_idpersona_seq');
COMMENT ON SEQUENCE cuidador_idpersona_seq IS 'Secuencia para generar identificadores únicos para la tabla Cuidador.';

ALTER TABLE Cuidador
DROP CONSTRAINT IF EXISTS CK_CodigoPostal_Cuidador;

ALTER TABLE Cuidador
ADD CONSTRAINT CK_CodigoPostal_Cuidador
CHECK (CodigoPostal BETWEEN 1000 AND 99999);

COMMENT ON CONSTRAINT CK_CodigoPostal_Cuidador ON Cuidador IS 'Restricción CHECK que valida que el Código Postal tenga entre 4 y 5 dígitos.';

-- ========
-- Limpiador 
-- =======
CREATE TABLE Limpiador (
    IdPersona INTEGER,
    Nombre VARCHAR(20),
    ApellidoMaterno VARCHAR(20),
    ApellidoPaterno VARCHAR(20),
    FechaNacimiento DATE,
    Sexo VARCHAR(10),
    Calle VARCHAR(20) ,
    Colonia VARCHAR(20),
    Ciudad VARCHAR(20),
    CodigoPostal INTEGER,
    NumInterior INTEGER,
    NumExterior INTEGER,
    Ubicacion VARCHAR(20),
    Horario VARCHAR(10),
    Salario REAL
);
ALTER TABLE Limpiador ADD CONSTRAINT pk_limpiador PRIMARY KEY (IdPersona);

ALTER TABLE Limpiador ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN ApellidoMaterno SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN ApellidoPaterno SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN Colonia SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN Ciudad SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN CodigoPostal SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN NumExterior SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN NumInterior SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN Ubicacion SET NOT NULL;

ALTER TABLE Limpiador ALTER COLUMN Nombre TYPE VARCHAR(100);
ALTER TABLE Limpiador ALTER COLUMN ApellidoMaterno TYPE VARCHAR(100);
ALTER TABLE Limpiador ALTER COLUMN ApellidoPaterno TYPE VARCHAR(100);
ALTER TABLE Limpiador ALTER COLUMN Calle TYPE VARCHAR(100);
ALTER TABLE Limpiador ALTER COLUMN Colonia TYPE VARCHAR(100);
ALTER TABLE Limpiador ALTER COLUMN Ciudad TYPE VARCHAR(100);
ALTER TABLE Limpiador ALTER COLUMN Ubicacion TYPE VARCHAR(100);


ALTER TABLE Limpiador ADD CONSTRAINT CK_Sexo CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE Limpiador ADD CONSTRAINT CK_CodigoPostal_Limpiador CHECK (CodigoPostal BETWEEN 10000 AND 99999);
ALTER TABLE Limpiador ADD CONSTRAINT CK_NumInterior_Limpiador CHECK (NumInterior >= 0);
ALTER TABLE Limpiador ADD CONSTRAINT CK_NumExterior_Limpiador CHECK (NumExterior > 0);
ALTER TABLE Limpiador ADD CONSTRAINT CK_FechaNacimiento_Limpiador CHECK (FechaNacimiento <= CURRENT_DATE);
ALTER TABLE Limpiador ADD CONSTRAINT CK_EdadMaxima_Limpiador CHECK (FechaNacimiento >= CURRENT_DATE - INTERVAL '100 years');
ALTER TABLE Limpiador ADD CONSTRAINT CK_Nombre_Limpiador CHECK (Nombre <> '');
ALTER TABLE Limpiador ADD CONSTRAINT CK_ApellidoMaterno_Limpiador CHECK (ApellidoMaterno <> '');
ALTER TABLE Limpiador ADD CONSTRAINT CK_ApellidoPaterno_Limpiador CHECK (ApellidoPaterno <> '');
ALTER TABLE Limpiador ADD CONSTRAINT CK_Calle_Limpiador CHECK (Calle <> '');
ALTER TABLE Limpiador ADD CONSTRAINT CK_Colonia_Limpiador CHECK (Colonia <> '');
ALTER TABLE Limpiador ADD CONSTRAINT CK_Ciudad_Limpiador CHECK (Ciudad <> '');
ALTER TABLE Limpiador ADD CONSTRAINT CK_Horario_Limpiador CHECK (Horario IN ('Matutino', 'Vespertino'));
ALTER TABLE Limpiador ADD CONSTRAINT CK_Salario_Limpiador CHECK (Salario >= 0);


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

COMMENT ON CONSTRAINT CK_Nombre_Limpiador ON Limpiador IS 'Restricción CHECK que valida que el nombre no esté vacío.';
COMMENT ON CONSTRAINT CK_ApellidoMaterno_Limpiador ON Limpiador IS 'Restricción CHECK que valida que el apellido materno no esté vacío.';
COMMENT ON CONSTRAINT CK_ApellidoPaterno_Limpiador ON Limpiador IS 'Restricción CHECK que valida que el apellido paterno no esté vacío.';
COMMENT ON CONSTRAINT CK_Calle_Limpiador ON Limpiador IS 'Restricción CHECK que valida que la calle no esté vacía.';
COMMENT ON CONSTRAINT CK_Colonia_Limpiador ON Limpiador IS 'Restricción CHECK que valida que la colonia no esté vacía.';
COMMENT ON CONSTRAINT CK_Ciudad_Limpiador ON Limpiador IS 'Restricción CHECK que valida que la ciudad no esté vacía.';
COMMENT ON CONSTRAINT CK_CodigoPostal_Limpiador ON Limpiador IS 'Restricción CHECK que valida que el Código Postal tenga exactamente 5 dígitos.';
COMMENT ON CONSTRAINT CK_NumInterior_Limpiador ON Limpiador IS 'Restricción CHECK que valida que el Número Interior sea mayor o igual a 0.';
COMMENT ON CONSTRAINT CK_NumExterior_Limpiador ON Limpiador IS 'Restricción CHECK que valida que el Número Exterior sea mayor a 0.';
COMMENT ON CONSTRAINT CK_FechaNacimiento_Limpiador ON Limpiador IS 'Restricción CHECK que valida que la fecha de nacimiento no sea futura.';
COMMENT ON CONSTRAINT CK_EdadMaxima_Limpiador ON Limpiador IS 'Restricción CHECK que valida que la edad del limpiador no exceda los 100 años.';
COMMENT ON CONSTRAINT CK_Sexo ON Limpiador IS 'Restricción CHECK que valida que el valor de Sexo sea M, H u Otro.';
COMMENT ON CONSTRAINT CK_Horario_Limpiador ON Limpiador IS 'Restricción CHECK que valida que el horario sea Matutino o Vespertino.';
COMMENT ON CONSTRAINT CK_Salario_Limpiador ON Limpiador IS 'Restricción CHECK que valida que el salario sea mayor o igual a 0.';

COMMENT ON CONSTRAINT pk_limpiador ON Limpiador IS 'Restricción de entidad para la tabla Limpiador.';



CREATE SEQUENCE limpiador_idpersona_seq OWNED BY Limpiador.IdPersona;
ALTER TABLE Limpiador ALTER COLUMN IdPersona SET DEFAULT nextval('limpiador_idpersona_seq');
COMMENT ON SEQUENCE limpiador_idpersona_seq IS 'Secuencia para generar identificadores únicos para la tabla Limpiador.';


ALTER TABLE Limpiador
DROP CONSTRAINT IF EXISTS CK_CodigoPostal_Limpiador;

ALTER TABLE Limpiador
ADD CONSTRAINT CK_CodigoPostal_Limpiador
CHECK (CodigoPostal BETWEEN 1000 AND 99999);

COMMENT ON CONSTRAINT CK_CodigoPostal_Limpiador ON Limpiador IS 'Restricción CHECK que valida que el Código Postal tenga entre 4 y 5 dígitos.';

-- ========
-- Espectador
-- ========
CREATE TABLE Espectador (
    IdPersona INTEGER  ,
    Nombre VARCHAR(20),
    ApellidoMaterno VARCHAR(20),
    ApellidoPaterno VARCHAR(20),
    FechaNacimiento DATE,
    Sexo VARCHAR(10) ,
    HoraIngreso TIMETZ,
    HoraSalida TIMETZ
);

ALTER TABLE Espectador ADD CONSTRAINT pk_Espectador PRIMARY KEY (IdPersona);

ALTER TABLE Espectador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Espectador  ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Espectador  ALTER COLUMN ApellidoMaterno SET NOT NULL;
ALTER TABLE Espectador  ALTER COLUMN ApellidoPaterno SET NOT NULL;
ALTER TABLE Espectador  ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE Espectador  ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE Espectador  ALTER COLUMN HoraIngreso SET NOT NULL;
ALTER TABLE Espectador ALTER COLUMN HoraSalida SET NOT NULL; 


ALTER TABLE Espectador ALTER COLUMN Nombre TYPE VARCHAR(100);
ALTER TABLE Espectador ALTER COLUMN ApellidoMaterno TYPE VARCHAR(100);
ALTER TABLE Espectador ALTER COLUMN ApellidoPaterno TYPE VARCHAR(100);



ALTER TABLE Espectador ADD CONSTRAINT CK_Nombre_Espectador CHECK (Nombre <> '');
ALTER TABLE Espectador ADD CONSTRAINT CK_ApellidoMaterno_Espectador CHECK (ApellidoMaterno <> '');
ALTER TABLE Espectador ADD CONSTRAINT CK_ApellidoPaterno_Espectador CHECK (ApellidoPaterno <> '');
ALTER TABLE Espectador ADD CONSTRAINT CK_Sexo_Espectador CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE Espectador ADD CONSTRAINT CK_HoraIngreso_Espectador CHECK (HoraIngreso IS NOT NULL);
ALTER TABLE Espectador ADD CONSTRAINT CK_HoraSalida_Espectador CHECK (HoraSalida >= HoraIngreso);


ALTER TABLE Espectador ADD CONSTRAINT CK_FechaNacimiento_Espectador CHECK (FechaNacimiento <= CURRENT_DATE);
ALTER TABLE Espectador ADD CONSTRAINT CK_EdadMaxima_Espectador CHECK (FechaNacimiento >= CURRENT_DATE - INTERVAL '100 years');


COMMENT ON TABLE Espectador IS 'Tabla que almacena los datos personales de los espectadores de los torneos';

COMMENT ON COLUMN Espectador.IdPersona IS 'Identificador único del participante dentro del sistema';
COMMENT ON COLUMN Espectador.Nombre IS 'Nombre del espectador';
COMMENT ON COLUMN Espectador.ApellidoMaterno IS 'Apellido materno del espectador';
COMMENT ON COLUMN Espectador.ApellidoPaterno IS 'Apellido paterno del espectador';
COMMENT ON COLUMN Espectador.FechaNacimiento IS 'Fecha de nacimiento del espectador en formato YYYY-MM-DD';
COMMENT ON COLUMN Espectador.Sexo IS 'Sexo o identidad de género del participante (M, H u Otro)';
COMMENT ON COLUMN Espectador.HoraIngreso IS 'Hora de ingreso del espectador al evento';
COMMENT ON COLUMN Espectador.HoraSalida IS 'Hora de salida del espectador al evento';

COMMENT ON CONSTRAINT CK_Nombre_Espectador ON Espectador IS 'Restricción CHECK que valida que el nombre no esté vacío.';
COMMENT ON CONSTRAINT CK_ApellidoMaterno_Espectador ON Espectador IS 'Restricción CHECK que valida que el apellido materno no esté vacío.';
COMMENT ON CONSTRAINT CK_ApellidoPaterno_Espectador ON Espectador IS 'Restricción CHECK que valida que el apellido paterno no esté vacío.';
COMMENT ON CONSTRAINT CK_Sexo_Espectador ON Espectador IS 'Restricción CHECK que valida que el valor de Sexo sea M, H u Otro.';
COMMENT ON CONSTRAINT CK_HoraIngreso_Espectador ON Espectador IS 'Restricción CHECK que valida que la hora de ingreso no sea nula.';
COMMENT ON CONSTRAINT CK_HoraSalida_Espectador ON Espectador IS 'Restricción CHECK que valida que la hora de salida sea mayor o igual a la hora de ingreso.';
COMMENT ON CONSTRAINT CK_FechaNacimiento_Espectador ON Espectador IS 'Restricción CHECK que valida que la fecha de nacimiento sea anterior al día actual.';
COMMENT ON CONSTRAINT CK_EdadMaxima_Espectador ON Espectador IS 'Restricción CHECK que valida que la edad de un espectador máxima sea de 100 años.';

COMMENT ON CONSTRAINT pk_Espectador ON Espectador IS 'Llave primaria que identifica de forma única a cada espectador';

CREATE SEQUENCE seq_espectador
    START 1
    INCREMENT 1
    OWNED BY Espectador.IdPersona;

ALTER TABLE Espectador
ALTER COLUMN IdPersona SET DEFAULT nextval('seq_espectador');


ALTER TABLE Espectador DROP CONSTRAINT CK_HoraIngreso_Espectador;
ALTER TABLE Espectador DROP CONSTRAINT CK_HoraSalida_Espectador;
ALTER TABLE Espectador ALTER COLUMN HoraIngreso DROP NOT NULL;
ALTER TABLE Espectador ALTER COLUMN HoraSalida DROP NOT NULL;
ALTER TABLE Espectador
DROP COLUMN HoraIngreso,
DROP COLUMN HoraSalida;


-- DATOS -------------------------------------


-- ========
-- 7. CorreoCuidador 
-- =======
CREATE TABLE CorreoCuidador (
    IdPersona INTEGER,
    Correo VARCHAR (254)
);
ALTER TABLE CorreoCuidador ADD CONSTRAINT pk_correo_cuidador PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoCuidador ADD CONSTRAINT fk_correo_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

COMMENT ON TABLE CorreoCuidador IS 'Tabla que almacena los correos electrónicos de los cuidadores.';
COMMENT ON COLUMN CorreoCuidador.IdPersona IS 'Identificador único del cuidador.';
COMMENT ON COLUMN CorreoCuidador.Correo IS 'Correo electrónico del cuidador.';
COMMENT ON CONSTRAINT pk_correo_cuidador ON CorreoCuidador IS 'Restricción de entidad para la tabla CorreoCuidador.';
COMMENT ON CONSTRAINT fk_correo_cuidador_cuidador ON CorreoCuidador IS 'Restricción referencial que vincula CorreoCuidador con Cuidador.';

-- ========
-- 8. TelefonoCuidador
-- =======
CREATE TABLE TelefonoCuidador(
    IdPersona INTEGER,
    Telefono CHAR(10)
);
ALTER TABLE TelefonoCuidador ADD CONSTRAINT pk_telefono_cuidador PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoCuidador ADD CONSTRAINT fk_telefono_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE TelefonoCuidador
    ADD CONSTRAINT CK_TelefonoCuidador
    CHECK (
        Telefono ~ '^[0-9]{10}$'
    );

COMMENT ON TABLE TelefonoCuidador IS 'Tabla que almacena los teléfonos de los cuidadores.';
COMMENT ON COLUMN TelefonoCuidador.IdPersona IS 'Identificador único del cuidador.';
COMMENT ON COLUMN TelefonoCuidador.Telefono IS 'Número de teléfono del cuidador.';
COMMENT ON CONSTRAINT fk_telefono_cuidador_cuidador ON TelefonoCuidador IS 'Restricción referencial que vincula TelefonoCuidador con Cuidador.';
COMMENT ON CONSTRAINT pk_telefono_cuidador ON TelefonoCuidador IS 'Restricción de entidad para la tabla TelefonoCuidador.';
COMMENT ON CONSTRAINT CK_TelefonoCuidador ON TelefonoCuidador IS 'Restricción CHECK que verifica que el teléfono tenga exactamente 10 dígitos.';

-- ========
-- 4. CorreoEncargadoRegistro (Va después de EncargadoRegistro)
-- =======
CREATE TABLE CorreoEncargadoRegistro (
    IdPersona INTEGER,
    Correo VARCHAR(254)
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
    IdPersona INTEGER,
    Telefono CHAR(10)
);
ALTER TABLE TelefonoEncargadoRegistro ADD CONSTRAINT pk_telefono_encargado_registro PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoEncargadoRegistro ADD CONSTRAINT fk_telefono_encargado_registro FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE TelefonoEncargadoRegistro
    ADD CONSTRAINT CK_TelefonoEncargadoRegistro
    CHECK (
        Telefono ~ '^[0-9]{10}$'
    );

COMMENT ON TABLE TelefonoEncargadoRegistro IS 'Tabla que almacena los números telefónicos asociados a cada encargado de registro.';
COMMENT ON COLUMN TelefonoEncargadoRegistro.IdPersona IS 'Identificador del encargado de registro al que pertenece el número telefónico (llave foránea hacia EncargadoRegistro).';
COMMENT ON COLUMN TelefonoEncargadoRegistro.Telefono IS 'Número telefónico del encargado de registro; debe contener 10 dígitos.';

COMMENT ON CONSTRAINT pk_telefono_encargado_registro ON TelefonoEncargadoRegistro IS 'Llave primaria compuesta por IdPersona y Telefono.';
COMMENT ON CONSTRAINT fk_telefono_encargado_registro ON TelefonoEncargadoRegistro IS 'Llave foránea que referencia al encargado de registro correspondiente, con política ON DELETE RESTRICT ON UPDATE CASCADE.';
COMMENT ON CONSTRAINT CK_TelefonoEncargadoRegistro ON TelefonoEncargadoRegistro IS 'Restricción CHECK que verifica que el teléfono tenga exactamente 10 dígitos.';


-- ========
-- 3. CorreoLimpiador (Va después de Limpiador)
-- =======
CREATE TABLE CorreoLimpiador (
    IdPersona INTEGER,
    Correo VARCHAR(254)
);
ALTER TABLE CorreoLimpiador ADD CONSTRAINT pk_correo_limpiador PRIMARY KEY (IdPersona, Correo);
ALTER TABLE CorreoLimpiador ADD CONSTRAINT fk_correo_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona) ON DELETE RESTRICT ON UPDATE CASCADE;

COMMENT ON TABLE CorreoLimpiador IS 'Tabla que almacena los correos electrónicos de los limpiadores.';
COMMENT ON COLUMN CorreoLimpiador.IdPersona IS 'Identificador único de la persona limpiadora.';
COMMENT ON COLUMN CorreoLimpiador.Correo IS 'Correo electrónico de la persona limpiadora.';
COMMENT ON CONSTRAINT pk_correo_limpiador ON CorreoLimpiador IS 'Restricción de entidad para la tabla CorreoLimpiador.';
COMMENT ON CONSTRAINT fk_correo_limpiador_limpiador ON CorreoLimpiador IS 'Restricción referencial que vincula CorreoLimpiador con Limpiador.';


-- ========
-- 4. TelefonoLimpiador (Va después de Limpiador)
-- =======
CREATE TABLE TelefonoLimpiador (
    IdPersona INTEGER,
    Telefono CHAR(10)
);
ALTER TABLE TelefonoLimpiador ADD CONSTRAINT pk_telefono_limpiador PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoLimpiador ADD CONSTRAINT fk_telefono_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE TelefonoLimpiador
    ADD CONSTRAINT CK_TelefonoLimpiador
    CHECK (
        Telefono ~ '^[0-9]{10}$'
    );

COMMENT ON TABLE TelefonoLimpiador IS 'Tabla que almacena los teléfonos de los limpiadores.';
COMMENT ON COLUMN TelefonoLimpiador.IdPersona IS 'Identificador único de la persona limpiadora.';
COMMENT ON COLUMN TelefonoLimpiador.Telefono IS 'Número de teléfono de la persona limpiadora.';
COMMENT ON CONSTRAINT pk_telefono_limpiador ON TelefonoLimpiador IS 'Restricción de entidad para la tabla TelefonoLimpiador.';
COMMENT ON CONSTRAINT fk_telefono_limpiador_limpiador ON TelefonoLimpiador IS 'Restricción referencial que vincula TelefonoLimpiador con Limpiador.';
COMMENT ON CONSTRAINT CK_TelefonoLimpiador ON TelefonoLimpiador IS 'Restricción CHECK que verifica que el teléfono tenga exactamente 10 dígitos.';

-- ========
-- 3. CorreoVendedor 
-- =======
CREATE TABLE CorreoVendedor(
    IdPersona INTEGER,
    Correo VARCHAR(254)
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
    IdPersona INTEGER,
    Telefono CHAR(10)
);
ALTER TABLE TelefonoVendedor ADD CONSTRAINT pk_telefono_vendedor PRIMARY KEY (IdPersona, Telefono);
ALTER TABLE TelefonoVendedor ADD CONSTRAINT fk_telefono_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE TelefonoVendedor
    ADD CONSTRAINT CK_TelefonoVendedor
    CHECK (
        Telefono ~ '^[0-9]{10}$'
    );

COMMENT ON TABLE TelefonoVendedor IS 'Tabla que almacena los teléfonos de los vendedores.';
COMMENT ON COLUMN TelefonoVendedor.IdPersona IS 'Identificador único del vendedor.';
COMMENT ON COLUMN TelefonoVendedor.Telefono IS 'Número de teléfono del vendedor.';
COMMENT ON CONSTRAINT pk_telefono_vendedor ON TelefonoVendedor IS 'Restricción de entidad para la tabla TeléfonoVendedor.';
COMMENT ON CONSTRAINT fk_telefono_vendedor_vendedor ON TelefonoVendedor IS 'Restricción referencial que vincula TelefonoVendedor con Vendedor.';
COMMENT ON CONSTRAINT CK_TelefonoVendedor ON TelefonoVendedor IS 'Restricción CHECK que verifica que el teléfono tenga exactamente 10 dígitos.';

-- ========
-- 5. CorreoParticipante
-- ========
CREATE TABLE CorreoParticipante (
    IdPersona INTEGER,
    Correo VARCHAR(254)
);

ALTER TABLE CorreoParticipante 
ADD CONSTRAINT pk_CorreoParticipante PRIMARY KEY (IdPersona, Correo);

ALTER TABLE CorreoParticipante 
ADD CONSTRAINT fk_Participante_Correo FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE CorreoParticipante ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE CorreoParticipante ALTER COLUMN IdPersona SET NOT NULL;

COMMENT ON TABLE CorreoParticipante IS 'Tabla que almacena las direcciones de correo electrónico asociadas a cada participante de la UNAM.';

COMMENT ON COLUMN CorreoParticipante.IdPersona IS 'Identificador del participante al que pertenece el correo.';
COMMENT ON COLUMN CorreoParticipante.Correo IS 'Dirección de correo electrónico del participante. Puede haber más de una por persona.';

COMMENT ON CONSTRAINT pk_CorreoParticipante ON CorreoParticipante IS 'Llave primaria compuesta que asegura que un mismo participante no tenga correos repetidos.';
COMMENT ON CONSTRAINT fk_Participante_Correo ON CorreoParticipante IS 'Llave foránea que vincula cada correo con el participante correspondiente. Se eliminan los correos si el participante es eliminado.';

-- ========
-- 8. TelefonoParticipante
-- ========
CREATE TABLE TelefonoParticipante (
    IdPersona INTEGER ,
    Telefono CHAR(10)
);

ALTER TABLE TelefonoParticipante 
ADD CONSTRAINT PK_TelefonoParticipante PRIMARY KEY (IdPersona, Telefono);

ALTER TABLE TelefonoParticipante 
ADD CONSTRAINT FK_Telefono_Participante 
FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE TelefonoParticipante
    ADD CONSTRAINT CK_TelefonoParticipante
    CHECK (
        Telefono ~ '^[0-9]{10}$'
    );

COMMENT ON TABLE TelefonoParticipante IS 'Tabla que almacena los números telefónicos asociados a los participantes de la UNAM.';

COMMENT ON COLUMN TelefonoParticipante.IdPersona IS 'Identificador del participante de la UNAM al que pertenece el número telefónico';
COMMENT ON COLUMN TelefonoParticipante.Telefono IS 'Número telefónico de contacto del participante. Se almacena con una longitud fija de 10 dígitos';

COMMENT ON CONSTRAINT PK_TelefonoParticipante ON TelefonoParticipante IS 'Llave primaria compuesta que impide duplicar números telefónicos para un mismo participante.';
COMMENT ON CONSTRAINT FK_Telefono_Participante ON TelefonoParticipante IS 'Llave foránea que vincula cada teléfono con el participante correspondiente. Se eliminan los teléfonos en cascada si el participante es eliminado.';
COMMENT ON CONSTRAINT CK_TelefonoParticipante ON TelefonoParticipante IS 'Restricción CHECK que verifica que el teléfono tenga exactamente 10 dígitos.';


---- TRABAJAR -------------------------------------------------
-- ========
-- TrabajarVendedor 
-- =======
CREATE TABLE TrabajarVendedor(
    Edicion INTEGER,
    IdPersona INTEGER
);
ALTER TABLE TrabajarVendedor ADD CONSTRAINT fk_trabajar_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;
ALTER TABLE TrabajarVendedor ADD CONSTRAINT fk_trabajar_vendedor_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE TrabajarVendedor ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE TrabajarVendedor ALTER COLUMN IdPersona SET NOT NULL;

COMMENT ON TABLE TrabajarVendedor IS 'Tabla que registra la relación de trabajo entre los vendedores y los eventos.';
COMMENT ON COLUMN TrabajarVendedor.IdPersona IS 'Identificador único del vendedor.';
COMMENT ON COLUMN TrabajarVendedor.Edicion IS 'Edición del evento en la que el vendedor trabaja.';
COMMENT ON CONSTRAINT fk_trabajar_vendedor_vendedor ON TrabajarVendedor IS 'Restricción referencial que vincula TrabajarVendedor con Vendedor.';
COMMENT ON CONSTRAINT fk_trabajar_vendedor_evento ON TrabajarVendedor IS 'Restricción referencial que vincula TrabajarVendedor con Evento.';

-- ========
-- TrabajarCuidador 
-- =======
CREATE TABLE TrabajarCuidador (
    Edicion INTEGER, 
    IdPersona INTEGER
);

ALTER TABLE TrabajarCuidador 
ADD CONSTRAINT fk_trabajar_cuidador_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE TrabajarCuidador 
ADD CONSTRAINT fk_trabajar_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE TrabajarCuidador ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE TrabajarCuidador ALTER COLUMN IdPersona SET NOT NULL;

COMMENT ON TABLE TrabajarCuidador IS 'Tabla que registra la participación de los cuidadores en diferentes ediciones de eventos.';
COMMENT ON COLUMN TrabajarCuidador.Edicion IS 'Número de edición del evento en el que participa el cuidador (llave foránea hacia Evento).';
COMMENT ON COLUMN TrabajarCuidador.IdPersona IS 'Identificador del cuidador que trabaja en la edición (llave foránea hacia Cuidador).';

COMMENT ON CONSTRAINT fk_trabajar_cuidador_evento ON TrabajarCuidador IS 'Llave foránea que referencia la edición del evento, con política ON DELETE RESTRICT ON UPDATE CASCADE.';
COMMENT ON CONSTRAINT fk_trabajar_cuidador_cuidador ON TrabajarCuidador IS 'Llave foránea que referencia al cuidador que trabaja en la edición, con política ON DELETE RESTRICT ON UPDATE CASCADE.';


-- ========
--  TrabajarLimpiador
-- =======
CREATE TABLE TrabajarLimpiador (
    IdPersona INTEGER,
    Edicion INTEGER
);
ALTER TABLE TrabajarLimpiador ADD CONSTRAINT fk_trabajar_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE TrabajarLimpiador ADD CONSTRAINT fk_trabajar_limpiador_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE TrabajarLimpiador ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE TrabajarLimpiador ALTER COLUMN IdPersona SET NOT NULL;

COMMENT ON TABLE TrabajarLimpiador IS 'Tabla que registra la relación de trabajo entre los limpiadores y los eventos.';
COMMENT ON COLUMN TrabajarLimpiador.IdPersona IS 'Identificador único de la persona limpiadora.';
COMMENT ON COLUMN TrabajarLimpiador.Edicion IS 'Edición del evento en la que el limpiador trabaja.';
COMMENT ON CONSTRAINT fk_trabajar_limpiador_limpiador ON TrabajarLimpiador IS 'Restricción referencial que vincula TrabajarLimpiador con Limpiador.';
COMMENT ON CONSTRAINT fk_trabajar_limpiador_evento ON TrabajarLimpiador IS 'Restricción referencial que vincula TrabajarLimpiador con Evento.';

-- ========
-- TrabajarEncargadoRegistro 
-- =======

CREATE TABLE TrabajarEncargadoRegistro (
    Edicion INTEGER, 
    IdPersona INTEGER
);

ALTER TABLE TrabajarEncargadoRegistro 
ADD CONSTRAINT fk_trabajar_encargado_registro_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE TrabajarEncargadoRegistro 
ADD CONSTRAINT fk_trabajar_encargado_registro_encargado FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE TrabajarEncargadoRegistro ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE TrabajarEncargadoRegistro ALTER COLUMN IdPersona SET NOT NULL;

COMMENT ON TABLE TrabajarEncargadoRegistro IS 'Tabla que registra la participación de los encargados de registro en diferentes ediciones de eventos.';
COMMENT ON COLUMN TrabajarEncargadoRegistro.Edicion IS 'Número de edición del evento en el que participa el encargado (llave foránea hacia Evento).';
COMMENT ON COLUMN TrabajarEncargadoRegistro.IdPersona IS 'Identificador del encargado de registro que trabaja en la edición (llave foránea hacia EncargadoRegistro).';

COMMENT ON CONSTRAINT fk_trabajar_encargado_registro_evento ON TrabajarEncargadoRegistro IS 'Llave foránea que referencia la edición del evento, con política ON DELETE RESTRICT ON UPDATE CASCADE.';
COMMENT ON CONSTRAINT fk_trabajar_encargado_registro_encargado ON TrabajarEncargadoRegistro IS 'Llave foránea que referencia al encargado de registro que trabaja en la edición, con política ON DELETE RESTRICT ON UPDATE CASCADE.';


--- COMPRAS---------------------------------------------


-- ========
-- Alimento 
-- ========
CREATE TABLE Alimento (
    IdAlimento INTEGER, 
    IdPersona INTEGER , 
    FechaDeCaducidad DATE ,
    Nombre VARCHAR(20),
    Tipo VARCHAR(20),
    Precio REAL
);

ALTER TABLE Alimento ADD CONSTRAINT pk_alimento PRIMARY KEY (IdAlimento);
ALTER TABLE Alimento ADD CONSTRAINT fk_alimento_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE Alimento ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Alimento ALTER COLUMN FechaDeCaducidad SET NOT NULL;
ALTER TABLE Alimento ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Alimento ALTER COLUMN Tipo SET NOT NULL;
ALTER TABLE Alimento ALTER COLUMN Precio SET NOT NULL;


ALTER TABLE Alimento ALTER COLUMN Nombre TYPE VARCHAR(100);

ALTER TABLE Alimento ADD CONSTRAINT CK_Precio_Alimento CHECK (Precio > 0);
ALTER TABLE Alimento ADD CONSTRAINT CK_Nombre_Alimento CHECK (Nombre <> '');
ALTER TABLE Alimento ADD CONSTRAINT CK_Tipo_Alimento CHECK (Tipo <> '');


COMMENT ON TABLE Alimento IS 'Tabla que contiene los alimentos ofrecidos por los vendedores en el evento.';
COMMENT ON COLUMN Alimento.IdAlimento IS 'Identificador único del alimento.';
COMMENT ON COLUMN Alimento.IdPersona IS 'Identificador del vendedor que ofrece el alimento (llave foránea hacia Vendedor).';
COMMENT ON COLUMN Alimento.FechaDeCaducidad IS 'Fecha de caducidad del alimento.';
COMMENT ON COLUMN Alimento.Nombre IS 'Nombre del alimento.';
COMMENT ON COLUMN Alimento.Tipo IS 'Tipo o categoría del alimento.';
COMMENT ON COLUMN Alimento.Precio IS 'Precio del alimento; debe ser un valor positivo.';
COMMENT ON CONSTRAINT CK_Precio_Alimento ON Alimento IS 'Restricción CHECK que valida que el precio del alimento sea mayor a 0.';
COMMENT ON CONSTRAINT CK_Nombre_Alimento ON Alimento IS 'Restricción CHECK que valida que el nombre del alimento no esté vacío.';
COMMENT ON CONSTRAINT CK_Tipo_Alimento ON Alimento IS 'Restricción CHECK que valida que el tipo del alimento no esté vacío.';

COMMENT ON CONSTRAINT pk_alimento ON Alimento IS 'Llave primaria de la tabla Alimento.';
COMMENT ON CONSTRAINT fk_alimento_vendedor ON Alimento IS 'Llave foránea que referencia al vendedor correspondiente, con política ON DELETE RESTRICT ON UPDATE CASCADE.';

CREATE SEQUENCE alimento_idalimento_seq OWNED BY Alimento.IdAlimento;
ALTER TABLE Alimento ALTER COLUMN IdAlimento SET DEFAULT nextval('alimento_idalimento_seq');
COMMENT ON SEQUENCE alimento_idalimento_seq IS 'Secuencia para generar identificadores únicos para la tabla Alimento.';

ALTER TABLE Alimento
ALTER COLUMN FechaDeCaducidad DROP NOT NULL;

-- ======== 
-- ComprarEncargadoRegistro 
-- ========

CREATE TABLE ComprarEncargadoRegistro (
    IdPersona INTEGER, 
    IdAlimento INTEGER, 
    MetodoDePago VARCHAR(20),
    Cantidad REAL, 
    Fecha TIMESTAMPTZ
);

ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT fk_comprar_encargado_registro_encargado FOREIGN KEY (IdPersona) REFERENCES EncargadoRegistro(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT fk_comprar_encargado_registro_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE ComprarEncargadoRegistro ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ComprarEncargadoRegistro ALTER COLUMN IdAlimento SET NOT NULL;
ALTER TABLE ComprarEncargadoRegistro ALTER COLUMN MetodoDePago SET NOT NULL;
ALTER TABLE ComprarEncargadoRegistro ALTER COLUMN Cantidad SET NOT NULL;

ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT CK_Cantidad_ComprarEncargadoRegistro CHECK (Cantidad > 0);
ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT CK_MetodoDePago_ComprarEncargadoRegistro CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia'));
ALTER TABLE ComprarEncargadoRegistro ADD CONSTRAINT CK_hora_compra CHECK (EXTRACT(HOUR FROM Fecha AT TIME ZONE 'America/Mexico_City') >= 9 AND EXTRACT(HOUR FROM Fecha AT TIME ZONE 'America/Mexico_City') < 21);

COMMENT ON TABLE ComprarEncargadoRegistro IS 'Tabla que registra las compras realizadas por los encargados de registro, incluyendo el método de pago y la cantidad adquirida.';
COMMENT ON COLUMN ComprarEncargadoRegistro.IdPersona IS 'Identificador del encargado de registro que realiza la compra (llave foránea hacia EncargadoRegistro).';
COMMENT ON COLUMN ComprarEncargadoRegistro.IdAlimento IS 'Identificador del alimento comprado (llave foránea hacia Alimento).';
COMMENT ON COLUMN ComprarEncargadoRegistro.MetodoDePago IS 'Método de pago utilizado en la compra; puede ser Tarjeta, Efectivo o Transferencia.';
COMMENT ON COLUMN ComprarEncargadoRegistro.Cantidad IS 'Cantidad de unidades del alimento compradas; debe ser mayor a 0.';
COMMENT ON CONSTRAINT CK_Cantidad_ComprarEncargadoRegistro ON ComprarEncargadoRegistro IS 'Restricción CHECK que valida que la cantidad comprada sea mayor a 0.';
COMMENT ON CONSTRAINT CK_MetodoDePago_ComprarEncargadoRegistro ON ComprarEncargadoRegistro IS 'Restricción CHECK que valida que el método de pago sea uno de los
    especificados: Tarjeta, Efectivo o Transferencia.';
COMMENT ON CONSTRAINT CK_hora_compra ON ComprarEncargadoRegistro IS 'Restricción CHECK que valida que la compra se realice entre las 9:00 y las 21:00 horas, hora local de Ciudad de México.';

COMMENT ON CONSTRAINT fk_comprar_encargado_registro_encargado ON ComprarEncargadoRegistro IS 'Llave foránea que referencia al encargado de registro comprador, con política ON DELETE RESTRICT ON UPDATE CASCADE.';
COMMENT ON CONSTRAINT fk_comprar_encargado_registro_alimento ON ComprarEncargadoRegistro IS 'Llave foránea que referencia al alimento adquirido, con política ON DELETE RESTRICT ON UPDATE CASCADE.';

-- ========
-- ComprarLimpiador  
-- =======
CREATE TABLE ComprarLimpiador (
    IdPersona INTEGER,
    IdAlimento INTEGER,
    MetodoDePago VARCHAR(20),
    Cantidad REAL, 
    Fecha TIMESTAMPTZ
);
ALTER TABLE ComprarLimpiador ADD CONSTRAINT fk_comprar_limpiador_limpiador FOREIGN KEY (IdPersona) REFERENCES Limpiador(IdPersona) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE ComprarLimpiador ADD CONSTRAINT fk_comprar_limpiador_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE ComprarLimpiador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ComprarLimpiador ALTER COLUMN IdAlimento SET NOT NULL;
ALTER TABLE ComprarLimpiador ALTER COLUMN MetodoDePago SET NOT NULL;
ALTER TABLE ComprarLimpiador ALTER COLUMN Cantidad SET NOT NULL;

ALTER TABLE ComprarLimpiador ADD CONSTRAINT CK_Cantidad_ComprarLimpiador CHECK (Cantidad > 0);
ALTER TABLE ComprarLimpiador ADD CONSTRAINT CK_MetodoDePago_ComprarLimpiador CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia'));
ALTER TABLE ComprarLimpiador ADD CONSTRAINT CK_hora_compra CHECK (EXTRACT(HOUR FROM Fecha AT TIME ZONE 'America/Mexico_City') >= 9 AND EXTRACT(HOUR FROM Fecha AT TIME ZONE 'America/Mexico_City') < 21);

COMMENT ON TABLE ComprarLimpiador IS 'Tabla que registra las compras realizadas por los limpiadores.';
COMMENT ON COLUMN ComprarLimpiador.IdPersona IS 'Identificador único de la persona limpiadora que realiza la compra.';
COMMENT ON COLUMN ComprarLimpiador.IdAlimento IS 'Identificador único del alimento comprado.';
COMMENT ON COLUMN ComprarLimpiador.MetodoDePago IS 'Método de pago utilizado para la compra.';
COMMENT ON COLUMN ComprarLimpiador.Cantidad IS 'Cantidad de alimento comprada.';
COMMENT ON CONSTRAINT CK_Cantidad_ComprarLimpiador ON ComprarLimpiador IS 'Restricción CHECK que valida que la cantidad comprada sea mayor a 0.';
COMMENT ON CONSTRAINT CK_MetodoDePago_ComprarLimpiador ON ComprarLimpiador IS 'Restricción CHECK que valida que el método de pago sea uno de los especificados: Tarjeta, Efectivo o Transferencia.';
COMMENT ON CONSTRAINT CK_hora_compra ON ComprarLimpiador IS 'Restricción CHECK que valida que la compra se realice entre las 9:00 y las 21:00 horas, hora local de Ciudad de México.';

COMMENT ON CONSTRAINT fk_comprar_limpiador_limpiador ON ComprarLimpiador IS 'Restricción referencial que vincula ComprarLimpiador con Limpiador.';
COMMENT ON CONSTRAINT fk_comprar_limpiador_alimento ON ComprarLimpiador IS 'Restricción referencial que vincula ComprarLimpiador con Alimento.';


-- ========
-- ComprarCuidador 
-- ========
CREATE TABLE ComprarCuidador (
    IdPersona INTEGER ,
    IdAlimento INTEGER,
    MetodoDePago VARCHAR(20),
    Cantidad REAL, 
    Fecha TIMESTAMPTZ
);
ALTER TABLE ComprarCuidador ADD CONSTRAINT fk_comprar_cuidador_cuidador FOREIGN KEY (IdPersona) REFERENCES Cuidador(IdPersona) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE ComprarCuidador ADD CONSTRAINT fk_comprar_cuidador_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE ComprarCuidador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ComprarCuidador ALTER COLUMN IdAlimento SET NOT NULL;
ALTER TABLE ComprarCuidador ALTER COLUMN MetodoDePago SET NOT NULL;
ALTER TABLE ComprarCuidador ALTER COLUMN Cantidad SET NOT NULL;

ALTER TABLE ComprarCuidador ADD CONSTRAINT CK_Cantidad_ComprarCuidador CHECK (Cantidad > 0);
ALTER TABLE ComprarCuidador ADD CONSTRAINT CK_MetodoDePago_ComprarCuidador CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia'));
ALTER TABLE ComprarCuidador ADD CONSTRAINT CK_hora_compra CHECK (EXTRACT(HOUR FROM Fecha AT TIME ZONE 'America/Mexico_City') >= 9 AND EXTRACT(HOUR FROM Fecha AT TIME ZONE 'America/Mexico_City') < 21);

COMMENT ON TABLE ComprarCuidador IS 'Tabla que registra las compras realizadas por los cuidadores.';
COMMENT ON COLUMN ComprarCuidador.IdPersona IS 'Identificador único de la persona cuidadora que realiza la compra.';
COMMENT ON COLUMN ComprarCuidador.IdAlimento IS 'Identificador único del alimento comprado.';
COMMENT ON COLUMN ComprarCuidador.MetodoDePago IS 'Método de pago utilizado para la compra.';
COMMENT ON COLUMN ComprarCuidador.Cantidad IS 'Cantidad de alimento comprada.';
COMMENT ON CONSTRAINT CK_Cantidad_ComprarCuidador ON ComprarCuidador IS 'Restricción CHECK que valida que la cantidad comprada sea mayor a 0.';
COMMENT ON CONSTRAINT CK_MetodoDePago_ComprarCuidador ON ComprarCuidador IS 'Restricción CHECK que valida que el método de pago sea uno de los especificados: Tarjeta, Efectivo o Transferencia.';
COMMENT ON CONSTRAINT fk_comprar_cuidador_cuidador ON ComprarCuidador IS 'Restricción referencial que vincula ComprarCuidador con Cuidador.';
COMMENT ON CONSTRAINT fk_comprar_cuidador_alimento ON ComprarCuidador IS 'Restricción referencial que vincula ComprarCuidador con Alimento.';
COMMENT ON CONSTRAINT CK_hora_compra ON ComprarCuidador IS 'Restricción CHECK que valida que la compra se realice entre las 9:00 y las 21:00 horas, hora local de Ciudad de México.';


-- ========
-- ComprarVendedor 
-- =======
CREATE TABLE ComprarVendedor (
    IdPersona INTEGER,
    IdAlimento INTEGER,
    MetodoDePago VARCHAR(20),
    Cantidad REAL, 
    Fecha TIMESTAMPTZ
);
ALTER TABLE ComprarVendedor  ADD CONSTRAINT fk_comprar_vendedor_vendedor FOREIGN KEY (IdPersona) REFERENCES Vendedor (IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;
ALTER TABLE ComprarVendedor ADD CONSTRAINT fk_comprar_vendedor_alimento FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE ComprarVendedor ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ComprarVendedor ALTER COLUMN IdAlimento SET NOT NULL;
ALTER TABLE ComprarVendedor ALTER COLUMN MetodoDePago SET NOT NULL;
ALTER TABLE ComprarVendedor ALTER COLUMN Cantidad SET NOT NULL;

ALTER TABLE ComprarVendedor ADD CONSTRAINT CK_Cantidad_ComprarVendedor CHECK (Cantidad > 0);
ALTER TABLE ComprarVendedor ADD CONSTRAINT CK_MetodoDePago_ComprarVendedor CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia'));
ALTER TABLE ComprarVendedor ADD CONSTRAINT CK_hora_compra CHECK (EXTRACT(HOUR FROM Fecha AT TIME ZONE 'America/Mexico_City') >= 9 AND EXTRACT(HOUR FROM Fecha AT TIME ZONE 'America/Mexico_City') < 21);

COMMENT ON TABLE ComprarVendedor IS 'Tabla que registra las compras realizadas por los vendedores.';
COMMENT ON COLUMN ComprarVendedor.IdPersona IS 'Identificador único del vendedor.';
COMMENT ON COLUMN ComprarVendedor.IdAlimento IS 'Identificador único del alimento comprado.';
COMMENT ON COLUMN ComprarVendedor.MetodoDePago IS 'Método de pago utilizado para la compra.';
COMMENT ON COLUMN ComprarVendedor.Cantidad IS 'Cantidad de alimento comprada.';
COMMENT ON CONSTRAINT CK_Cantidad_ComprarVendedor ON ComprarVendedor IS 'Restricción CHECK que valida que la cantidad comprada sea mayor a 0.';
COMMENT ON CONSTRAINT CK_MetodoDePago_ComprarVendedor ON ComprarVendedor IS 'Restricción CHECK que valida que el método de pago sea uno de los especificados: Tarjeta, Efectivo o Transferencia.';
COMMENT ON CONSTRAINT CK_hora_compra ON ComprarVendedor IS 'Restricción CHECK que valida que la compra se realice entre las 9:00 y las 21:00 horas, hora local de Ciudad de México.';
COMMENT ON CONSTRAINT fk_comprar_vendedor_vendedor ON ComprarVendedor IS 'Restricción referencial que vincula ComprarVendedor con Vendedor.';
COMMENT ON CONSTRAINT fk_comprar_vendedor_alimento ON ComprarVendedor IS 'Restricción referencial que vincula ComprarVendedor con Alimento.';

-- ========
-- ComprarEspectador
-- ========
CREATE TABLE ComprarEspectador (
    IdPersona INTEGER,
    IdAlimento INTEGER,
    MetodoDePago VARCHAR(20),
    Cantidad REAL,
    Fecha TIMESTAMPTZ
);

ALTER TABLE ComprarEspectador 
ADD CONSTRAINT FK_Espectador_Comprar FOREIGN KEY (IdPersona) REFERENCES Espectador(IdPersona)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE ComprarEspectador 
ADD CONSTRAINT FK_Alimento_Comprar FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE ComprarEspectador ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ComprarEspectador ALTER COLUMN IdAlimento SET NOT NULL;
ALTER TABLE ComprarEspectador ALTER COLUMN MetodoDePago SET NOT NULL;
ALTER TABLE ComprarEspectador ALTER COLUMN Cantidad SET NOT NULL;

ALTER TABLE ComprarEspectador ADD CONSTRAINT CK_Cantidad_ComprarEspectador CHECK (Cantidad > 0);
ALTER TABLE ComprarEspectador ADD CONSTRAINT CK_MetodoDePago_ComprarEspectador CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia'));    
ALTER TABLE ComprarEspectador ADD CONSTRAINT CK_hora_compra CHECK (EXTRACT(HOUR FROM Fecha AT TIME ZONE 'America/Mexico_City') >= 9 AND EXTRACT(HOUR FROM Fecha AT TIME ZONE 'America/Mexico_City') < 21);

COMMENT ON TABLE ComprarEspectador IS 'Tabla que registra las compras de alimentos realizadas por los espectadores.';

COMMENT ON COLUMN ComprarEspectador.IdPersona IS 'Identificador del espectador que realiza la compra.';
COMMENT ON COLUMN ComprarEspectador.IdAlimento IS 'Identificador del alimento adquirido por el espectador.';
COMMENT ON COLUMN ComprarEspectador.MetodoDePago IS 'Método de pago utilizado: Tarjeta, Efectivo o Transferencia.';
COMMENT ON COLUMN ComprarEspectador.Cantidad IS 'Cantidad total del alimento adquirido por el espectador.';
COMMENT ON CONSTRAINT CK_Cantidad_ComprarEspectador ON ComprarEspectador IS 'Restricción CHECK que valida que la cantidad comprada sea mayor a 0.';
COMMENT ON CONSTRAINT CK_MetodoDePago_ComprarEspectador ON ComprarEspectador IS 'Restricción CHECK que valida que el método de pago sea uno de los especificados: Tarjeta, Efectivo o Transferencia.';
COMMENT ON CONSTRAINT CK_hora_compra ON ComprarEspectador IS 'Restricción CHECK que valida que la compra se realice entre las 9:00 y las 21:00 horas, hora local de Ciudad de México.';

COMMENT ON CONSTRAINT FK_Espectador_Comprar ON ComprarEspectador IS 'Llave foránea que relaciona la compra con el espectador correspondiente. No permite eliminar un espectador si tiene compras registradas';
COMMENT ON CONSTRAINT FK_Alimento_Comprar ON ComprarEspectador IS 'Llave foránea que vincula el alimento con la compra. No permite eliminar un alimento si está asociado a una compra.';

-- ========
-- ComprarParticipanteUNAM
-- ========
CREATE TABLE ComprarParticipanteUNAM (
    IdPersona INTEGER,
    IdAlimento INTEGER,
    MetodoDePago VARCHAR(20),
    Cantidad REAL,
    Fecha TIMESTAMPTZ   
);


ALTER TABLE ComprarParticipanteUNAM 
ADD CONSTRAINT FK_Participante_Comprar FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE ComprarParticipanteUNAM 
ADD CONSTRAINT FK_Alimento_Comprar_Participante FOREIGN KEY (IdAlimento) REFERENCES Alimento(IdAlimento)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE ComprarParticipanteUNAM ADD CONSTRAINT CK_hora_compra CHECK (EXTRACT(HOUR FROM Fecha AT TIME ZONE 'America/Mexico_City') >= 9 AND EXTRACT(HOUR FROM Fecha AT TIME ZONE 'America/Mexico_City') < 21);

ALTER TABLE ComprarParticipanteUNAM ALTER COLUMN Cantidad SET NOT NULL;
ALTER TABLE ComprarParticipanteUNAM ALTER COLUMN MetodoDePago SET NOT NULL;
ALTER TABLE ComprarParticipanteUNAM ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ComprarParticipanteUNAM ALTER COLUMN IdAlimento SET NOT NULL;

ALTER TABLE ComprarParticipanteUNAM ADD CONSTRAINT CK_Cantidad_ComprarParticipanteUNAM CHECK (Cantidad > 0);
ALTER TABLE ComprarParticipanteUNAM ADD CONSTRAINT CK_MetodoDePago_ComprarParticipanteUNAM CHECK (MetodoDePago IN ('Tarjeta', 'Efectivo', 'Transferencia'));

COMMENT ON TABLE ComprarParticipanteUNAM IS 'Tabla que registra las compras de alimentos realizadas por los participantes de la UNAM.';

COMMENT ON COLUMN ComprarParticipanteUNAM.IdPersona IS 'Identificador del participante de la UNAM que realiza la compra.';
COMMENT ON COLUMN ComprarParticipanteUNAM.IdAlimento IS 'Identificador del alimento adquirido por el participante.';
COMMENT ON COLUMN ComprarParticipanteUNAM.MetodoDePago IS 'Método de pago utilizado: Tarjeta, Efectivo o Transferencia.';
COMMENT ON COLUMN ComprarParticipanteUNAM.Cantidad IS 'Cantidad total de alimento comprada por el participante.';
COMMENT ON CONSTRAINT CK_Cantidad_ComprarParticipanteUNAM ON ComprarParticipanteUNAM IS 'Restricción CHECK que valida que la cantidad comprada sea mayor a 0.';
COMMENT ON CONSTRAINT CK_MetodoDePago_ComprarParticipanteUNAM ON ComprarParticipanteUNAM IS 'Restricción CHECK que valida que el método de pago sea uno de los especificados: Tarjeta, Efectivo o Transferencia.';
COMMENT ON CONSTRAINT CK_hora_compra ON ComprarParticipanteUNAM IS 'Restricción CHECK que valida que la compra se realice entre las 9:00 y las 21:00 horas, hora local de Ciudad de México.';

COMMENT ON CONSTRAINT FK_Participante_Comprar ON ComprarParticipanteUNAM IS 'Llave foránea que vincula la compra con el participante correspondiente. No permite eliminar un participante si tiene compras registradas';
COMMENT ON CONSTRAINT FK_Alimento_Comprar_Participante ON ComprarParticipanteUNAM IS 'Llave foránea que vincula el alimento con la compra. No permite eliminar un alimento si está asociado a una compra.';


-----------Relaciones extra --------------------------------

-- ========
-- EncargadoInscribirParticipante (Va después de EncargadoRegistro y ParticipanteUNAM)
-- =======

CREATE TABLE EncargadoInscribirParticipante (
    IdPersona_encargado INTEGER , 
    IdPersona_participante INTEGER , 
    Fecha TIMESTAMPTZ
);

ALTER TABLE EncargadoInscribirParticipante 
ADD CONSTRAINT fk_encargado_inscribir_participante_encargado FOREIGN KEY (IdPersona_encargado) REFERENCES EncargadoRegistro(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_encargado_inscribir_participante_participante FOREIGN KEY (IdPersona_participante) REFERENCES ParticipanteUNAM(IdPersona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE EncargadoInscribirParticipante ALTER COLUMN IdPersona_encargado SET NOT NULL;
ALTER TABLE EncargadoInscribirParticipante ALTER COLUMN IdPersona_participante SET NOT NULL;
ALTER TABLE EncargadoInscribirParticipante ALTER COLUMN Fecha SET NOT NULL;

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
    Edicion INTEGER,
    IdPersona INTEGER,
    Fecha TIMESTAMPTZ,
    Costo REAL
);

Alter TABLE ParticipanteInscribirEvento ADD CONSTRAINT PK_ParticipanteInscribirEvento PRIMARY KEY (Edicion, IdPersona);

ALTER TABLE ParticipanteInscribirEvento 
ADD CONSTRAINT FK_InscribirEvento_Edicion FOREIGN KEY (Edicion) REFERENCES Evento(Edicion)
ON DELETE CASCADE
ON UPDATE CASCADE;


ALTER TABLE ParticipanteInscribirEvento 
ADD CONSTRAINT FK_InscribirEvento_Participante FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE ParticipanteInscribirEvento ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE ParticipanteInscribirEvento ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE ParticipanteInscribirEvento ALTER COLUMN Fecha SET NOT NULL;
ALTER TABLE ParticipanteInscribirEvento ALTER COLUMN Costo SET NOT NULL;

ALTER TABLE ParticipanteInscribirEvento ADD CONSTRAINT CK_Costo_Positive CHECK (Costo >= 0);
ALTER TABLE ParticipanteInscribirEvento ADD CONSTRAINT CK_Fecha_Inscripcion CHECK (Fecha <= CURRENT_DATE);
ALTER TABLE ParticipanteInscribirEvento ALTER COLUMN Costo SET NOT NULL;
ALTER TABLE ParticipanteInscribirEvento ALTER COLUMN Fecha SET NOT NULL;

ALTER TABLE ParticipanteInscribirEvento ADD CONSTRAINT uq_inscripcionEvento UNIQUE (Edicion, IdPersona);

COMMENT ON TABLE ParticipanteInscribirEvento IS 'Tabla que registra la inscripción de participantes de la UNAM a las distintas ediciones de los eventos.';

COMMENT ON COLUMN ParticipanteInscribirEvento.Edicion IS 'Número o identificador de la edición del evento en la que se inscribe el participante.';
COMMENT ON COLUMN ParticipanteInscribirEvento.IdPersona IS 'Identificador del participante de la UNAM inscrito en el evento.';
COMMENT ON COLUMN ParticipanteInscribirEvento.Fecha IS 'Fecha en que el participante realizó su inscripción al evento.';
COMMENT ON COLUMN ParticipanteInscribirEvento.Costo IS 'Costo total de inscripción pagado por el participante.';
COMMENT ON CONSTRAINT CK_Costo_Positive ON ParticipanteInscribirEvento IS 'Restricción CHECK que asegura que el costo de inscripción sea un valor no negativo.';
COMMENT ON CONSTRAINT CK_Fecha_Inscripcion ON ParticipanteInscribirEvento IS 'Restricción CHECK que garantiza que la fecha de inscripción no sea posterior a la fecha actual.';
COMMENT ON CONSTRAINT uq_inscripcionEvento ON ParticipanteInscribirEvento IS 'Restricción de unicidad que asegura que un participante no pueda inscribirse más de una vez en la misma edición del evento.';

COMMENT ON CONSTRAINT PK_ParticipanteInscribirEvento ON ParticipanteInscribirEvento IS 'Llave primaria compuesta por Edicion e IdPersona que garantiza que un participante no se inscriba dos veces al mismo evento.';
COMMENT ON CONSTRAINT FK_InscribirEvento_Edicion ON ParticipanteInscribirEvento IS 'Llave foránea que vincula la inscripción con la edición correspondiente del evento. Si la edición se elimina, también se eliminan las inscripciones asociadas.';
COMMENT ON CONSTRAINT FK_InscribirEvento_Participante ON ParticipanteInscribirEvento IS 'Llave foránea que vincula la inscripción con el participante. Si el participante se elimina, también se eliminan sus registros de inscripción.';

ALTER TABLE ParticipanteInscribirEvento DROP CONSTRAINT PK_ParticipanteInscribirEvento;
-- ========
-- Asistir
-- ========
CREATE TABLE Asistir (
    Edicion INTEGER,
    IdPersona INTEGER
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

ALTER TABLE ParticipanteInscribirEvento ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE ParticipanteInscribirEvento ALTER COLUMN IdPersona SET NOT NULL;

COMMENT ON TABLE Asistir IS 'Tabla que registra la asistencia de los espectadores a las distintas ediciones de los eventos.';

COMMENT ON COLUMN Asistir.Edicion IS 'Número o identificador de la edición del evento al que asiste el espectador';
COMMENT ON COLUMN Asistir.IdPersona IS 'Identificador del espectador que asiste al evento.';

COMMENT ON CONSTRAINT PK_Asistir ON Asistir IS 'Llave primaria compuesta por Edicion e IdPersona que evita registros duplicados de asistencia.';
COMMENT ON CONSTRAINT FK_Asistir_Edicion ON Asistir IS 'Llave foránea que vincula la asistencia con la edición correspondiente del evento. Si el evento se elimina, también se eliminan los registros de asistencia asociados.';
COMMENT ON CONSTRAINT FK_Asistir_Espectador ON Asistir IS 'Llave foránea que vincula la asistencia con el espectador correspondiente. Si el espectador se elimina, también se eliminan sus registros de asistencia.';

ALTER TABLE Asistir DROP CONSTRAINT PK_Asistir;

ALTER TABLE Asistir
ADD COLUMN HoraIngreso TIMETZ;

ALTER TABLE Asistir
ADD COLUMN HoraSalida TIMETZ;

ALTER TABLE Asistir ALTER COLUMN HoraIngreso SET NOT NULL;
ALTER TABLE Asistir ALTER COLUMN HoraSalida SET NOT NULL;

ALTER TABLE Asistir ADD CONSTRAINT CK_HoraSalida_Asistir CHECK (HoraSalida >= HoraIngreso);

COMMENT ON COLUMN Asistir.HoraIngreso IS 'Hora de ingreso del espectador al evento.';
COMMENT ON COLUMN Asistir.HoraSalida IS 'Hora de salida del espectador del evento.';
COMMENT ON CONSTRAINT CK_HoraSalida_Asistir ON Asistir IS 'Restricción CHECK que valida que la hora de salida sea mayor o igual a la hora de ingreso.';

--------------- JUEGO 

-- ========
-- CuentaPokemon
-- =======

CREATE TABLE CuentaPokemonGo (
    IdPersona INTEGER ,
    CodigoDeEntrenador INTEGER,
    Equipo VARCHAR(20),
    Nivel SMALLINT,
    NombreDeUsuario VARCHAR(30) NOT NULL UNIQUE
);


ALTER TABLE CuentaPokemonGo ADD CONSTRAINT pk_cuenta_pokemon_go PRIMARY KEY (IdPersona, CodigoDeEntrenador);
ALTER TABLE CuentaPokemonGo ADD CONSTRAINT fk_cuenta_pokemon_go_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE CuentaPokemonGo ALTER COLUMN Equipo SET NOT NULL;
ALTER TABLE CuentaPokemonGo ALTER COLUMN Nivel SET NOT NULL;
ALTER TABLE CuentaPokemonGo ALTER COLUMN NombreDeUsuario SET NOT NULL;
ALTER TABLE CuentaPokemonGo ALTER COLUMN CodigoDeEntrenador SET NOT NULL;

ALTER TABLE CuentaPokemonGo ADD CONSTRAINT CK_Nivel_CuentaPokemonGo CHECK (Nivel >= 1);
ALTER TABLE CuentaPokemonGo ADD CONSTRAINT CK_Equipo_CuentaPokemonGo CHECK (Equipo IN ('Valor', 'Sabiduría', 'Instinto'));
ALTER TABLE CuentaPokemonGo ADD CONSTRAINT CK_NombreDeUsuario_CuentaPokemonGo CHECK (NombreDeUsuario <> '');
ALTER TABLE CuentaPokemonGo ADD CONSTRAINT uq_NombreDeUsuario UNIQUE (NombreDeUsuario);

COMMENT ON TABLE CuentaPokemonGo IS 'Tabla que almacena la información de las cuentas de Pokémon Go de los participantes.';
COMMENT ON COLUMN CuentaPokemonGo.IdPersona IS 'Identificador único del participante UNAM propietario de la cuenta de Pokémon Go.';
COMMENT ON COLUMN CuentaPokemonGo.CodigoDeEntrenador IS 'Código de entrenador de la cuenta de Pokémon Go.';
COMMENT ON COLUMN CuentaPokemonGo.Equipo IS 'Equipo al que pertenece la cuenta de Pokémon Go.';
COMMENT ON COLUMN CuentaPokemonGo.Nivel IS 'Nivel de la cuenta de Pokémon Go.';
COMMENT ON COLUMN CuentaPokemonGo.NombreDeUsuario IS 'Nombre de usuario de la cuenta de Pokémon Go.';
COMMENT ON CONSTRAINT CK_Nivel_CuentaPokemonGo ON CuentaPokemonGo IS 'Restricción CHECK que valida que el nivel de la cuenta sea mayor o igual a 1.';
COMMENT ON CONSTRAINT CK_Equipo_CuentaPokemonGo ON CuentaPokemonGo IS 'Restricción CHECK que valida que el equipo sea uno de los especificados: Valor, Sabiduría o Instinto.';
COMMENT ON CONSTRAINT CK_NombreDeUsuario_CuentaPokemonGo ON CuentaPokemonGo IS 'Restricción CHECK que valida que el nombre de usuario no esté vacío.';
COMMENT ON CONSTRAINT uq_NombreDeUsuario ON CuentaPokemonGo IS 'Restricción de unicidad que asegura que el nombre de usuario sea único en la tabla.';

COMMENT ON CONSTRAINT pk_cuenta_pokemon_go ON CuentaPokemonGo IS 'Restricción de entidad para la tabla CuentaPokemonGo.';
COMMENT ON CONSTRAINT fk_cuenta_pokemon_go_participante_unam ON CuentaPokemonGo IS 'Restricción referencial que vincula CuentaPokemonGo con ParticipanteUNAM.';

CREATE SEQUENCE cuenta_pokemongo_codentrenador_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    OWNED BY CuentaPokemonGo.CodigoDeEntrenador;

ALTER TABLE CuentaPokemonGo
    ALTER COLUMN CodigoDeEntrenador
    SET DEFAULT nextval('cuenta_pokemongo_codentrenador_seq');

COMMENT ON SEQUENCE cuenta_pokemongo_codentrenador_seq IS
'Secuencia para generar automáticamente los códigos de entrenador en la tabla CuentaPokemonGo.';


-- ========
-- Pokemon
-- =======
CREATE TABLE Pokemon (
    IdPokemon INTEGER,
    IdPersona INTEGER,
    CodigoDeEntrenador INTEGER,
    Nombre VARCHAR(50),
    Sexo VARCHAR(10) ,
    Peso REAL,
    PuntosDeCombate INTEGER,
    Shiny BOOLEAN,
    Tipo VARCHAR(20),
    Especie VARCHAR(20)
);

ALTER TABLE Pokemon ADD CONSTRAINT pk_pokemon PRIMARY KEY (IdPokemon);

ALTER TABLE Pokemon ADD CONSTRAINT fk_pokemon_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador)
    REFERENCES CuentaPokemonGo (IdPersona, CodigoDeEntrenador) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE Pokemon ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN Peso SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN PuntosDeCombate SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN Shiny SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN Tipo SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN Especie SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Pokemon ALTER COLUMN CodigoDeEntrenador SET NOT NULL;

ALTER TABLE Pokemon ADD CONSTRAINT CK_Sexo_Pokemon CHECK (Sexo IN ('M', 'H', 'Otro'));
ALTER TABLE Pokemon ADD CONSTRAINT CK_PuntosDeCombate_Pokemon CHECK (PuntosDeCombate >= 0);
ALTER TABLE Pokemon ADD CONSTRAINT CK_Peso_Pokemon CHECK (Peso > 0);
ALTER TABLE Pokemon ADD CONSTRAINT CK_Nombre_Pokemon CHECK (Nombre <> '');
ALTER TABLE Pokemon ADD CONSTRAINT CK_Tipo_Pokemon CHECK (Tipo <> '');
ALTER TABLE Pokemon ADD CONSTRAINT CK_Especie_Pokemon CHECK (Especie <> '');


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
COMMENT ON CONSTRAINT CK_Sexo_Pokemon ON Pokemon IS 'Restricción CHECK que valida que el sexo del pokémon sea uno de los especificados: M, H u Otro.';
COMMENT ON CONSTRAINT CK_PuntosDeCombate_Pokemon ON Pokemon IS 'Restricción CHECK que valida que los puntos de combate del pokémon sean mayores o iguales a 0.';    
COMMENT ON CONSTRAINT CK_Peso_Pokemon ON Pokemon IS 'Restricción CHECK que valida que el peso del pokémon sea mayor a 0.';
COMMENT ON CONSTRAINT CK_Nombre_Pokemon ON Pokemon IS 'Restricción CHECK que valida que el nombre del pokémon no esté vacío.';
COMMENT ON CONSTRAINT CK_Tipo_Pokemon ON Pokemon IS 'Restricción CHECK que valida que el tipo del pokémon no esté vacío.';
COMMENT ON CONSTRAINT CK_Especie_Pokemon ON Pokemon IS 'Restricción CHECK que valida que la especie del pokémon no esté vacía.';

COMMENT ON CONSTRAINT pk_pokemon ON Pokemon IS 'Restricción de entidad para la tabla Pokemon.';
COMMENT ON CONSTRAINT fk_pokemon_cuenta_pokemon_go ON Pokemon IS 'Restricción referencial que vincula Pokemon con CuentaPokemonGo.';

CREATE SEQUENCE pokemon_idpokemon_seq OWNED BY Pokemon.IdPokemon;
ALTER TABLE Pokemon ALTER COLUMN IdPokemon SET DEFAULT nextval('pokemon_idpokemon_seq');
COMMENT ON SEQUENCE pokemon_idpokemon_seq IS 'Secuencia para generar identificadores únicos para la tabla Pokemon.';

ALTER TABLE Pokemon
DROP CONSTRAINT IF EXISTS CK_Peso_Pokemon;

ALTER TABLE Pokemon
ADD CONSTRAINT CK_Peso_Pokemon
CHECK (Peso >= 0);
COMMENT ON CONSTRAINT CK_Peso_Pokemon ON Pokemon IS 'Restricción CHECK que valida que el peso del pokémon sea mayor o igual a 0.';

------------- TORNEOS ------------

-- ========
-- TorneoCapturaShinys 
-- ========
CREATE TABLE TorneoCapturaShinys (
    Edicion INTEGER,
    IdTorneo INTEGER ,
    IdPersona INTEGER,
    CantidadAPremiar REAL
);
   
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT pk_torneo_captura_shinys PRIMARY KEY (Edicion, IdTorneo);
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT fk_torneo_captura_shinys_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT fk_torneo_captura_shinys_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE TorneoCapturaShinys ADD CONSTRAINT CK_CantidadAPremiar_TorneoCapturaShinys CHECK (CantidadAPremiar >= 0);

ALTER TABLE TorneoCapturaShinys  ALTER COLUMN CantidadAPremiar SET DEFAULT 500.0;



COMMENT ON TABLE TorneoCapturaShinys IS 'Tabla que almacena la información de los torneos de captura de pokémones shiny.';
COMMENT ON COLUMN TorneoCapturaShinys.Edicion IS 'Edición del torneo de captura de pokémones shiny.';
COMMENT ON COLUMN TorneoCapturaShinys.IdTorneo IS 'Identificador único del torneo de captura de pokémones shiny.';
COMMENT ON COLUMN TorneoCapturaShinys.IdPersona IS 'Identificador único del participante UNAM que ganó el torneo.';
COMMENT ON COLUMN TorneoCapturaShinys.CantidadAPremiar IS 'Cantidad en dinero a premiar al ganador del torneo.';

COMMENT ON CONSTRAINT CK_CantidadAPremiar_TorneoCapturaShinys ON TorneoCapturaShinys IS 'Restricción CHECK que valida que la cantidad a premiar sea mayor o igual a 0.';

COMMENT ON CONSTRAINT pk_torneo_captura_shinys ON TorneoCapturaShinys IS 'Restricción de entidad para la tabla TorneoCapturaShinys.';
COMMENT ON CONSTRAINT fk_torneo_captura_shinys_evento ON TorneoCapturaShinys IS 'Restricción referencial que vincula TorneoCapturaShinys con Evento.';
COMMENT ON CONSTRAINT fk_torneo_captura_shinys_participante_unam ON TorneoCapturaShinys IS 'Restricción referencial que vincula TorneoCapturaShinys con ParticipanteUNAM.';


CREATE SEQUENCE torneocapturashinys_idtorneo_seq OWNED BY TorneoCapturaShinys.IdTorneo;
ALTER TABLE TorneoCapturaShinys ALTER COLUMN IdTorneo SET DEFAULT nextval('torneocapturashinys_idtorneo_seq');
COMMENT ON SEQUENCE torneocapturashinys_idtorneo_seq IS 'Secuencia para generar identificadores únicos para la tabla TorneoCapturaShinys.';

-- ========
-- TorneoDistanciaRecorrida
-- ========
CREATE TABLE TorneoDistanciaRecorrida (
    Edicion INTEGER,
    IdTorneo INTEGER,
    IdPersona INTEGER,
    CantidadAPremiar REAL 
);

ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT pk_torneo_distancia_recorrida PRIMARY KEY (Edicion, IdTorneo);
ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT fk_torneo_distancia_recorrida_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT fk_torneo_distancia_recorrida_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE TorneoDistanciaRecorrida ADD CONSTRAINT CK_CantidadAPremiar_TorneoDistanciaRecorrida CHECK (CantidadAPremiar >= 0);
ALTER TABLE TorneoDistanciaRecorrida ALTER COLUMN CantidadAPremiar SET DEFAULT 500.0;

COMMENT ON TABLE TorneoDistanciaRecorrida IS 'Tabla que almacena la información de los torneos de distancia recorrida.';
COMMENT ON COLUMN TorneoDistanciaRecorrida.Edicion IS 'Edición del torneo de distancia recorrida.';
COMMENT ON COLUMN TorneoDistanciaRecorrida.IdTorneo IS 'Identificador único del torneo de distancia recorrida.';
COMMENT ON COLUMN TorneoDistanciaRecorrida.IdPersona IS 'Identificador único del participante UNAM que ganó el torneo.';
COMMENT ON COLUMN TorneoDistanciaRecorrida.CantidadAPremiar IS 'Cantidad en dinero a premiar al ganador del torneo.';
COMMENT ON CONSTRAINT CK_CantidadAPremiar_TorneoDistanciaRecorrida ON TorneoDistanciaRecorrida IS 'Restricción CHECK que valida que la cantidad a premiar sea mayor o igual a 0.';

COMMENT ON CONSTRAINT pk_torneo_distancia_recorrida ON TorneoDistanciaRecorrida IS 'Restricción de entidad para la tabla TorneoDistanciaRecorrida.';
COMMENT ON CONSTRAINT fk_torneo_distancia_recorrida_evento ON TorneoDistanciaRecorrida IS 'Restricción referencial que vincula TorneoDistanciaRecorrida con Evento.';
COMMENT ON CONSTRAINT fk_torneo_distancia_recorrida_participante_unam ON TorneoDistanciaRecorrida IS 'Restricción referencial que vincula TorneoDistanciaRecorrida con ParticipanteUNAM.';

CREATE SEQUENCE torneodistanciarecorrida_idtorneo_seq OWNED BY TorneoDistanciaRecorrida.IdTorneo;
ALTER TABLE TorneoDistanciaRecorrida ALTER COLUMN IdTorneo SET DEFAULT nextval('torneodistanciarecorrida_idtorneo_seq');
COMMENT ON SEQUENCE torneodistanciarecorrida_idtorneo_seq IS 'Secuencia para generar identificadores únicos para la tabla TorneoDistanciaRecorrida.';

-- ========
-- TorneoPelea 
-- =======
CREATE TABLE TorneoPelea (
    Edicion INTEGER,
    IdTorneo INTEGER ,
    IdPersona INTEGER,
    CantidadAPremiar REAL
);
ALTER TABLE TorneoPelea ADD CONSTRAINT pk_torneo_pelea PRIMARY KEY (Edicion, IdTorneo);
ALTER TABLE TorneoPelea ADD CONSTRAINT fk_torneo_pelea_evento FOREIGN KEY (Edicion) REFERENCES Evento(Edicion) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE TorneoPelea ADD CONSTRAINT fk_torneo_pelea_participante_unam FOREIGN KEY (IdPersona) REFERENCES ParticipanteUNAM(IdPersona) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE TorneoPelea ADD CONSTRAINT CK_CantidadAPremiar_TorneoPelea CHECK (CantidadAPremiar >= 0);
ALTER TABLE TorneoPelea ALTER COLUMN CantidadAPremiar SET DEFAULT 500.0;

COMMENT ON TABLE TorneoPelea IS 'Tabla que almacena la información de los torneos de pelea.';
COMMENT ON COLUMN TorneoPelea.Edicion IS 'Edición del torneo de pelea.';
COMMENT ON COLUMN TorneoPelea.IdTorneo IS 'Identificador único del torneo de pelea.';
COMMENT ON COLUMN TorneoPelea.IdPersona IS 'Identificador único del participante UNAM que ganó el torneo.';
COMMENT ON COLUMN TorneoPelea.CantidadAPremiar IS 'Cantidad en dinero a premiar al ganador del torneo.';
COMMENT ON CONSTRAINT CK_CantidadAPremiar_TorneoPelea ON TorneoPelea IS 'Restricción CHECK que valida que la cantidad a premiar sea mayor o igual a 0.';

COMMENT ON CONSTRAINT pk_torneo_pelea ON TorneoPelea IS 'Restricción de entidad para la tabla TorneoPelea.';
COMMENT ON CONSTRAINT fk_torneo_pelea_evento ON TorneoPelea IS 'Restricción referencial que vincula TorneoPelea con Evento.';
COMMENT ON CONSTRAINT fk_torneo_pelea_participante_unam ON TorneoPelea IS 'Restricción referencial que vincula TorneoPelea con ParticipanteUNAM.';

CREATE SEQUENCE torneopelea_idtorneo_seq OWNED BY TorneoPelea.IdTorneo;
ALTER TABLE TorneoPelea ALTER COLUMN IdTorneo SET DEFAULT nextval('torneopelea_idtorneo_seq');
COMMENT ON SEQUENCE torneopelea_idtorneo_seq IS 'Secuencia para generar identificadores únicos para la tabla TorneoPelea.';


-- ========
-- PeleaTorneo 
-- =======
CREATE TABLE PeleaTorneo (
    Edicion INTEGER,
    IdTorneo INTEGER,
    NumeroPelea INTEGER,
    IdPersona INTEGER,
    CodigoDeEntrenador INTEGER,
    Fecha TIMESTAMPTZ,
    Fase INTEGER
);
ALTER TABLE PeleaTorneo ADD CONSTRAINT pk_pelea_torneo PRIMARY KEY (Edicion, IdTorneo, NumeroPelea);
ALTER TABLE PeleaTorneo ADD CONSTRAINT fk_pelea_torneo_torneo FOREIGN KEY (Edicion, IdTorneo) REFERENCES TorneoPelea(Edicion, IdTorneo) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE PeleaTorneo ADD CONSTRAINT fk_pelea_torneo_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE PeleaTorneo ALTER COLUMN CodigoDeEntrenador SET NOT NULL;
ALTER TABLE PeleaTorneo ALTER COLUMN Fecha SET NOT NULL;
ALTER TABLE PeleaTorneo ALTER COLUMN Fase SET NOT NULL;


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

CREATE SEQUENCE peleatorneo_numeropelea_seq OWNED BY PeleaTorneo.NumeroPelea;
ALTER TABLE PeleaTorneo ALTER COLUMN NumeroPelea SET DEFAULT nextval('peleatorneo_numeropelea_seq');
COMMENT ON SEQUENCE peleatorneo_numeropelea_seq IS 'Secuencia para generar números de pelea únicos dentro de cada torneo en la tabla PeleaTorneo.';

-- ========
-- Locacion
-- ========

CREATE TABLE Locacion (
    NombreLocacion VARCHAR(15),
    Latitud REAL,
    Longitud REAL
);

ALTER TABLE Locacion ADD CONSTRAINT pk_locacion PRIMARY KEY (NombreLocacion);

ALTER TABLE Locacion ALTER COLUMN Latitud SET NOT NULL;
ALTER TABLE Locacion ALTER COLUMN Longitud SET NOT NULL;

COMMENT ON TABLE Locacion IS 'Tabla que almacena las locaciones disponibles para registrar distancias recorridas.';
COMMENT ON COLUMN Locacion.NombreLocacion IS 'Nombre de la locación.';
COMMENT ON COLUMN Locacion.Latitud IS 'Latitud de la locación.';
COMMENT ON COLUMN Locacion.Longitud IS 'Longitud de la locación.';
COMMENT ON CONSTRAINT pk_locacion ON Locacion IS 'Restricción de entidad para la tabla Locacion.';

-- ========
-- DistanciaRecorrida
-- ========
CREATE TABLE DistanciaRecorrida (
    Edicion INTEGER,
    IdTorneo INTEGER,
    IdDistancia INTEGER ,
    IdPersona INTEGER,
    CodigoDeEntrenador INTEGER,
    NombreLocacion VARCHAR(15),
    Fecha DATE,
    Hora TIMETZ
);

ALTER TABLE DistanciaRecorrida ADD CONSTRAINT pk_distancia_recorrido PRIMARY KEY (Edicion, IdTorneo, IdDistancia);
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT fk_distancia_recorrida_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT fk_distancia_recorrida_torneo_distancia_recorrida FOREIGN KEY (Edicion, IdTorneo) REFERENCES TorneoDistanciaRecorrida(Edicion, IdTorneo) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE DistanciaRecorrida ADD CONSTRAINT fk_distancia_recorrida_locacion FOREIGN KEY (NombreLocacion) REFERENCES Locacion(NombreLocacion) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE DistanciaRecorrida ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE DistanciaRecorrida ALTER COLUMN CodigoDeEntrenador SET NOT NULL;
ALTER TABLE DistanciaRecorrida ALTER COLUMN NombreLocacion SET NOT NULL;
ALTER TABLE DistanciaRecorrida ALTER COLUMN Fecha SET NOT NULL;
ALTER TABLE DistanciaRecorrida ALTER COLUMN Hora SET NOT NULL;

ALTER TABLE DistanciaRecorrida ADD CONSTRAINT CK_distanciarecorrida_hora CHECK (EXTRACT(HOUR FROM Hora) >= 9 AND EXTRACT(HOUR FROM Hora) < 21);

COMMENT ON TABLE DistanciaRecorrida IS 'Tabla que almacena la información de las distancias recorridas por los participantes en los torneos.';
COMMENT ON COLUMN DistanciaRecorrida.Edicion IS 'Edición del torneo en la que se registró la distancia recorrida.';
COMMENT ON COLUMN DistanciaRecorrida.IdTorneo IS 'Identificador único del torneo de distancia recorrida.';
COMMENT ON COLUMN DistanciaRecorrida.IdDistancia IS 'Identificador único de la distancia recorrida.';
COMMENT ON COLUMN DistanciaRecorrida.IdPersona IS 'Identificador único del participante que recorrió la distancia.';
COMMENT ON COLUMN DistanciaRecorrida.CodigoDeEntrenador IS 'Código de entrenador de la cuenta de Pokémon Go del participante.';
COMMENT ON COLUMN DistanciaRecorrida.NombreLocacion IS 'Locación donde se registró la distancia recorrida.';
COMMENT ON COLUMN DistanciaRecorrida.Fecha IS 'Fecha en la que se registró la distancia recorrida.';
COMMENT ON COLUMN DistanciaRecorrida.Hora IS 'Hora en la que se registró la distancia recorrida.';

COMMENT ON CONSTRAINT fk_distancia_recorrida_locacion ON DistanciaRecorrida IS 'Restricción referencial que vincula DistanciaRecorrida con Locacion.';
COMMENT ON CONSTRAINT pk_distancia_recorrido ON DistanciaRecorrida IS 'Restricción de entidad para la tabla DistanciaRecorrida.';
COMMENT ON CONSTRAINT fk_distancia_recorrida_cuenta_pokemon_go ON DistanciaRecorrida IS 'Restricción referencial que vincula DistanciaRecorrida con CuentaPokemonGo.';
COMMENT ON CONSTRAINT fk_distancia_recorrida_torneo_distancia_recorrida ON DistanciaRecorrida IS 'Restricción referencial que vincula DistanciaRecorrida con TorneoDistanciaRecorrida.';
COMMENT ON CONSTRAINT CK_distanciarecorrida_hora ON DistanciaRecorrida IS 'Restricción CHECK que valida que la hora de registro de distancia esté dentro del horario permitido (9:00 a 21:00).';

CREATE SEQUENCE distanciarecorrida_iddistancia_seq
    START WITH 1
    INCREMENT BY 1
    OWNED BY DistanciaRecorrida.IdDistancia;

ALTER TABLE DistanciaRecorrida
    ALTER COLUMN IdDistancia
    SET DEFAULT nextval('distanciarecorrida_iddistancia_seq');
COMMENT ON SEQUENCE distanciarecorrida_iddistancia_seq IS 
'Secuencia para generar automáticamente IdDistancia en la tabla DistanciaRecorrida.';

-- ========
-- Utilizar 
-- ========
CREATE TABLE Utilizar (
    IdPokemon INTEGER,
    Edicion INTEGER,
    IdTorneo INTEGER ,
    NumeroPelea INTEGER
);
ALTER TABLE Utilizar ADD CONSTRAINT fk_utilizar_pokemon FOREIGN KEY (IdPokemon) REFERENCES Pokemon(IdPokemon) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE Utilizar ADD CONSTRAINT fk_utilizar_pelea_torneo FOREIGN KEY (Edicion, IdTorneo, NumeroPelea) REFERENCES PeleaTorneo(Edicion, IdTorneo, NumeroPelea) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE Utilizar ALTER COLUMN IdPokemon SET NOT NULL;
ALTER TABLE Utilizar ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE Utilizar ALTER COLUMN IdTorneo SET NOT NULL;
ALTER TABLE Utilizar ALTER COLUMN NumeroPelea SET NOT NULL;

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
    Edicion INTEGER,
    IdTorneo INTEGER,
    IdCaptura INTEGER   
);


ALTER TABLE CapturaPokemon ADD CONSTRAINT pk_captura_pokemon PRIMARY KEY (Edicion, IdTorneo, IdCaptura);
ALTER TABLE CapturaPokemon ADD CONSTRAINT fk_captura_pokemon_torneo_captura_shinys FOREIGN KEY (Edicion, IdTorneo) REFERENCES TorneoCapturaShinys(Edicion, IdTorneo) ON DELETE RESTRICT ON UPDATE CASCADE;

COMMENT ON TABLE CapturaPokemon IS 'Tabla que almacena la información de las capturas de pokémones en los torneos.';
COMMENT ON COLUMN CapturaPokemon.Edicion IS 'Edición del torneo en la que se realizó la captura.';
COMMENT ON COLUMN CapturaPokemon.IdTorneo IS 'Identificador único del torneo de captura de pokémones shiny.';
COMMENT ON COLUMN CapturaPokemon.IdCaptura IS 'Identificador único de la captura realizada.';
COMMENT ON CONSTRAINT pk_captura_pokemon ON CapturaPokemon IS 'Restricción de entidad para la tabla CapturaPokemon.';
COMMENT ON CONSTRAINT fk_captura_pokemon_torneo_captura_shinys ON CapturaPokemon IS 'Restricción referencial que vincula CapturaPokemon con TorneoCapturaShinys.';

CREATE SEQUENCE captura_pokemon_idcaptura_seq
    START WITH 1
    INCREMENT BY 1
    OWNED BY CapturaPokemon.IdCaptura;

ALTER TABLE CapturaPokemon
    ALTER COLUMN IdCaptura
    SET DEFAULT nextval('captura_pokemon_idcaptura_seq');
COMMENT ON SEQUENCE captura_pokemon_idcaptura_seq IS 
'Secuencia para generar automáticamente IdCaptura en la tabla CapturaPokemon.';


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


ALTER TABLE Registrar ADD CONSTRAINT fk_registrar_cuenta_pokemon_go FOREIGN KEY (IdPersona, CodigoDeEntrenador) REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE Registrar ADD CONSTRAINT fk_registrar_captura_pokemon FOREIGN KEY (Edicion, IdTorneo, IdCaptura) REFERENCES CapturaPokemon(Edicion, IdTorneo, IdCaptura) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE Registrar ADD CONSTRAINT fk_registrar_pokemon FOREIGN KEY (IdPokemon) REFERENCES Pokemon(IdPokemon) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE Registrar ADD CONSTRAINT CK_registrar_hora CHECK (EXTRACT(HOUR FROM Hora) >= 9 AND EXTRACT(HOUR FROM Hora) < 21);

ALTER TABLE Registrar ALTER COLUMN IdPokemon SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN CodigoDeEntrenador SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN IdCaptura SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN IdTorneo SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN Fecha SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN Hora SET NOT NULL;

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
COMMENT ON CONSTRAINT CK_registrar_hora ON Registrar IS 'Restricción CHECK que valida que la hora de captura esté dentro del horario permitido (9:00 a 21:00).';

-- ============================
-- InscripcionTorneoPelea
-- ============================
CREATE TABLE InscripcionTorneoPelea (
    Edicion INTEGER,
    IdTorneo INTEGER,
    IdPersona INTEGER,
    CodigoDeEntrenador INTEGER,
    FechaInscripcion TIMESTAMPTZ
);

ALTER TABLE InscripcionTorneoPelea
    ADD CONSTRAINT fk_inscripcion_pelea_torneo
    FOREIGN KEY (Edicion, IdTorneo)
    REFERENCES TorneoPelea(Edicion, IdTorneo)
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE InscripcionTorneoPelea
    ADD CONSTRAINT fk_inscripcion_pelea_cuenta
    FOREIGN KEY (IdPersona, CodigoDeEntrenador)
    REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador)
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE InscripcionTorneoPelea ALTER COLUMN FechaInscripcion SET NOT NULL;
ALTER TABLE InscripcionTorneoPelea ALTER COLUMN CodigoDeEntrenador SET NOT NULL;
ALTER TABLE InscripcionTorneoPelea ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE InscripcionTorneoPelea ALTER COLUMN IdTorneo SET NOT NULL;
ALTER TABLE InscripcionTorneoPelea ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE InscripcionTorneoPelea ALTER COLUMN FechaInscripcion SET DEFAULT CURRENT_DATE;

COMMENT ON TABLE InscripcionTorneoPelea IS 'Inscripciones al torneo de pelea Pokémon.';
COMMENT ON COLUMN InscripcionTorneoPelea.Edicion IS 'Edición del torneo de pelea.';
COMMENT ON COLUMN InscripcionTorneoPelea.IdTorneo IS 'Identificador del torneo de pelea.';
COMMENT ON COLUMN InscripcionTorneoPelea.IdPersona IS 'Persona inscrita.';
COMMENT ON COLUMN InscripcionTorneoPelea.CodigoDeEntrenador IS 'Código del entrenador inscrito.';
COMMENT ON COLUMN InscripcionTorneoPelea.FechaInscripcion IS 'Fecha de inscripción.';

COMMENT ON CONSTRAINT fk_inscripcion_pelea_torneo ON InscripcionTorneoPelea IS 'Restricción referencial que vincula InscripcionTorneoPelea con TorneoPelea.';
COMMENT ON CONSTRAINT fk_inscripcion_pelea_cuenta ON InscripcionTorneoPelea IS 'Restricción referencial que vincula InscripcionTorneoPelea con CuentaPokemonGo.';




-- ============================
-- InscripcionTorneoDistancia
-- ============================
CREATE TABLE InscripcionTorneoDistancia (
    Edicion INTEGER,
    IdTorneo INTEGER,
    IdPersona INTEGER,
    CodigoDeEntrenador INTEGER,
    FechaInscripcion TIMESTAMPTZ
);

ALTER TABLE InscripcionTorneoDistancia
    ADD CONSTRAINT fk_inscripcion_distancia_torneo
    FOREIGN KEY (Edicion, IdTorneo)
    REFERENCES TorneoDistanciaRecorrida(Edicion, IdTorneo)
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE InscripcionTorneoDistancia
    ADD CONSTRAINT fk_inscripcion_distancia_cuenta
    FOREIGN KEY (IdPersona, CodigoDeEntrenador)
    REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador)
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE InscripcionTorneoDistancia ALTER COLUMN FechaInscripcion SET NOT NULL;
ALTER TABLE InscripcionTorneoDistancia ALTER COLUMN CodigoDeEntrenador SET NOT NULL;
ALTER TABLE InscripcionTorneoDistancia ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE InscripcionTorneoDistancia ALTER COLUMN IdTorneo SET NOT NULL;
ALTER TABLE InscripcionTorneoDistancia ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE InscripcionTorneoDistancia ALTER COLUMN FechaInscripcion SET DEFAULT CURRENT_DATE;

COMMENT ON TABLE InscripcionTorneoDistancia IS 'Inscripciones al torneo de distancia Pokémon.';
COMMENT ON COLUMN InscripcionTorneoDistancia.Edicion IS 'Edición del torneo de distancia.';
COMMENT ON COLUMN InscripcionTorneoDistancia.IdTorneo IS 'Identificador del torneo de distancia.';
COMMENT ON COLUMN InscripcionTorneoDistancia.IdPersona IS 'Persona inscrita.';
COMMENT ON COLUMN InscripcionTorneoDistancia.CodigoDeEntrenador IS 'Código del entrenador inscrito.';
COMMENT ON COLUMN InscripcionTorneoDistancia.FechaInscripcion IS 'Fecha de inscripción.';

COMMENT ON CONSTRAINT fk_inscripcion_distancia_torneo ON InscripcionTorneoDistancia IS 'Restricción referencial que vincula InscripcionTorneoDistancia con TorneoDistancia.';
COMMENT ON CONSTRAINT fk_inscripcion_distancia_cuenta ON InscripcionTorneoDistancia IS 'Restricción referencial que vincula InscripcionTorneoDistancia con CuentaPokemonGo.';


-- ============================
-- InscripcionTorneoCaptura
-- ============================
CREATE TABLE InscripcionTorneoCaptura (
    Edicion INTEGER,
    IdTorneo INTEGER,
    IdPersona INTEGER,
    CodigoDeEntrenador INTEGER,
    FechaInscripcion TIMESTAMPTZ
);

ALTER TABLE InscripcionTorneoCaptura
    ADD CONSTRAINT fk_inscripcion_captura_torneo
    FOREIGN KEY (Edicion, IdTorneo)
    REFERENCES TorneoCapturaShinys(Edicion, IdTorneo)
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE InscripcionTorneoCaptura
    ADD CONSTRAINT fk_inscripcion_captura_cuenta
    FOREIGN KEY (IdPersona, CodigoDeEntrenador)
    REFERENCES CuentaPokemonGo(IdPersona, CodigoDeEntrenador)
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE InscripcionTorneoCaptura ALTER COLUMN FechaInscripcion SET NOT NULL;
ALTER TABLE InscripcionTorneoCaptura ALTER COLUMN CodigoDeEntrenador SET NOT NULL;
ALTER TABLE InscripcionTorneoCaptura ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE InscripcionTorneoCaptura ALTER COLUMN IdTorneo SET NOT NULL;
ALTER TABLE InscripcionTorneoCaptura ALTER COLUMN Edicion SET NOT NULL;
ALTER TABLE InscripcionTorneoCaptura ALTER COLUMN FechaInscripcion SET DEFAULT CURRENT_DATE;

COMMENT ON TABLE InscripcionTorneoCaptura IS 'Inscripciones al torneo de captura Pokémon.';
COMMENT ON COLUMN InscripcionTorneoCaptura.Edicion IS 'Edición del torneo de captura.';
COMMENT ON COLUMN InscripcionTorneoCaptura.IdTorneo IS 'Identificador del torneo de captura.';
COMMENT ON COLUMN InscripcionTorneoCaptura.IdPersona IS 'Persona inscrita.';
COMMENT ON COLUMN InscripcionTorneoCaptura.CodigoDeEntrenador IS 'Código del entrenador inscrito.';
COMMENT ON COLUMN InscripcionTorneoCaptura.FechaInscripcion IS 'Fecha de inscripción.';

COMMENT ON CONSTRAINT fk_inscripcion_captura_torneo ON InscripcionTorneoCaptura IS 'Restricción referencial que vincula InscripcionTorneoCaptura con TorneoCaptura.';
COMMENT ON CONSTRAINT fk_inscripcion_captura_cuenta ON InscripcionTorneoCaptura IS 'Restricción referencial que vincula InscripcionTorneoCaptura con CuentaPokemonGo.';
