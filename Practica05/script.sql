
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

