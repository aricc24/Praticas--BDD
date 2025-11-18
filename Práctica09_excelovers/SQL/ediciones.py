import random

# ============================================================
# CONFIGURACIÓN
# ============================================================

random.seed(777)   # ← SEMILLA FIJA

eventos = {
    1: '2023-04-10',
    2: '2023-07-14',
    3: '2024-05-11',
    4: '2024-11-02',
    5: '2025-02-02',
    6: '2025-12-02'
}

idpersonas = range(1, 151)
ediciones = list(eventos.keys())

# Estructuras que rellenaremos
participante_inscrito = {p: [] for p in idpersonas}
encargado_trabaja = {p: [] for p in idpersonas}

# ============================================================
# GENERAR INSCRIPCIONES DE PARTICIPANTES
# ============================================================

print("-- INSERTs autogenerados para ParticipanteInscribirEvento\n")

for idp in idpersonas:
    num_inscripciones = random.randint(1, 4)
    eds = random.sample(ediciones, num_inscripciones)
    participante_inscrito[idp] = eds  # guardamos

    for ed in eds:
        fecha = eventos[ed]
        print(
            f"INSERT INTO ParticipanteInscribirEvento(edicion, idpersona, fecha, costo) "
            f"VALUES ({ed}, {idp}, '{fecha}', 150);"
        )

# ============================================================
# GENERAR TRABAJOS DE ENCARGADOS
# ============================================================

print("\n-- INSERTs autogenerados para TrabajarEncargadoRegistro\n")

for idp in idpersonas:
    num_trabajos = random.randint(1, 3)
    eds = random.sample(ediciones, num_trabajos)
    encargado_trabaja[idp] = eds  # guardamos

    for ed in eds:
        print(
            f"INSERT INTO TrabajarEncargadoRegistro(edicion, idpersona) "
            f"VALUES ({ed}, {idp});"
        )

# ============================================================
# GENERAR INSERCIONES CONSISTENTES
# EncargadoInscribirParticipante
# ============================================================

print("\n-- INSERTs para EncargadoInscribirParticipante\n")

for encargado, eds_trabaja in encargado_trabaja.items():
    for ed in eds_trabaja:

        # Participantes que están inscritos en ESTA edición
        participantes_validos = [
            p for p, eds in participante_inscrito.items()
            if ed in eds
        ]

        if participantes_validos:
            n = random.randint(1, min(5, len(participantes_validos)))
            elegidos = random.sample(participantes_validos, n)
            fecha = eventos[ed]

            for p in elegidos:
                print(
                    f"INSERT INTO EncargadoInscribirParticipante "
                    f"(IdPersona_encargado, IdPersona_participante, fecha) "
                    f"VALUES ({encargado}, {p}, '{fecha}');"
                )

# ============================================================
# LISTA DE PARTICIPANTES POR EDICIÓN
# ============================================================

print("\n-- LISTA DE PARTICIPANTES POR EDICIÓN\n")

participantes_por_edicion = {ed: [] for ed in ediciones}

for p, eds in participante_inscrito.items():
    for ed in eds:
        participantes_por_edicion[ed].append(p)

for ed in ediciones:
    print(f"Edición {ed} ({eventos[ed]}):")
    print(participantes_por_edicion[ed])
    print()
