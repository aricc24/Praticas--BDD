
import random

# ------------------------------
# SEMILLA FIJA PARA RESULTADOS REPETIBLES
# ------------------------------
random.seed(42)


cuentas_de_personas = {84: 113, 128: 148, 39: 24, 65: 148, 121: 44, 21: 121, 115: 116, 117: 95, 29: 65, 144: 64, 22: 84, 141: 30, 142: 98, 83: 78, 24: 8, 132: 144, 120: 52, 48: 130, 82: 135, 150: 28, 28: 107, 131: 31, 109: 124, 92: 53, 60: 130, 100: 90, 45: 80, 111: 49, 74: 138, 97: 64, 57: 52, 69: 70, 68: 108, 51: 115, 40: 48, 85: 137, 72: 35, 50: 125, 49: 145, 44: 4, 126: 80, 147: 136, 106: 50, 80: 114, 5: 48, 79: 12, 62: 114, 148: 131, 26: 43, 136: 45, 140: 31, 35: 9, 118: 59, 19: 85, 34: 111, 55: 88, 59: 27, 52: 19, 104: 55, 78: 12, 67: 48, 2: 74, 123: 93, 31: 66, 75: 91, 94: 86, 33: 64, 130: 93, 3: 123, 149: 94, 110: 96, 90: 77, 1: 32, 119: 55, 71: 18, 102: 133, 61: 32, 98: 54, 107: 73, 25: 134, 86: 95, 116: 99, 38: 52, 125: 64, 64: 16, 17: 115, 146: 127, 135: 117, 4: 20}


Edicion1 = [4, 15, 16, 18, 20, 23, 24, 25, 26, 28, 32, 33, 34, 37, 43, 47, 49, 50, 56, 59, 62, 72, 73, 83, 84, 87, 90, 91, 93, 97, 98, 101, 102, 107, 108, 116, 117, 118, 120, 121, 124, 126, 129, 137, 138, 139, 143, 144, 147, 149]

Edicion2 =[16, 18, 21, 26, 32, 37, 40, 43, 44, 47, 53, 55, 56, 57, 58, 62, 64, 65, 69, 71, 75, 78, 83, 87, 88, 90, 93, 97, 98, 100, 101, 104, 105, 110, 111, 115, 116, 118, 119, 120, 123, 124, 125, 127, 128, 129, 130, 136, 140, 143, 146, 147]

Edicion3 = [2, 4, 5, 8, 10, 12, 20, 24, 27, 29, 31, 33, 34, 35, 38, 45, 47, 53, 57, 67, 68, 69, 70, 71, 72, 75, 80, 81, 85, 86, 88, 93, 95, 97, 100, 107, 108, 110, 111, 112, 117, 121, 125, 126, 129, 131, 134, 137, 140, 142, 143]

Edicion4 = [1, 3, 4, 11, 15, 16, 18, 26, 27, 30, 32, 33, 35, 39, 42, 43, 44, 45, 47, 55, 57, 58, 61, 62, 64, 65, 68, 72, 73, 74, 75, 77, 80, 84, 85, 87, 88, 89, 92, 94, 98, 103, 104, 112, 114, 117, 119, 122, 124, 125, 126, 130, 136, 137, 138, 139, 140, 141, 142, 143, 146, 148, 150]

Edicion5 = [2, 4, 8, 10, 11, 13, 14, 17, 18, 19, 20, 22, 24, 27, 28, 30, 33, 36, 37, 40, 41, 42, 45, 49, 50, 51, 52, 53, 56, 58, 60, 62, 64, 65, 66, 69, 71, 72, 73, 74, 80, 84, 85, 90, 91, 93, 96, 101, 104, 108, 111, 112, 113, 114, 117, 127, 129, 130, 139, 140, 145, 146, 147]

Edicion6= [1, 2, 6, 7, 8, 9, 13, 15, 16, 17, 20, 24, 25, 26, 27, 28, 30, 31, 32, 35, 36, 37, 42, 43, 45, 46, 48, 49, 52, 53, 54, 55, 56, 57, 60, 61, 63, 65, 67, 68, 73, 74, 76, 77, 78, 79, 82, 83, 84, 85, 87, 88, 90, 94, 99, 106, 108, 109, 110, 111, 112, 113, 114, 118, 119, 120, 121, 123, 126, 127, 128, 131, 132, 133, 135, 137, 138, 145, 148, 150]

eventos = {
    1: '2023-04-10',
    2: '2023-07-14',
    3: '2024-05-11',
    4: '2024-11-02',
    5: '2025-02-02',
    6: '2025-12-02'
}

import random

# ------------------------------
# SEMILLA FIJA
# ------------------------------
random.seed(42)

# ------------------------------
# MAPA DE CÓDIGOS DE ENTRENADOR
# ------------------------------
cuentas_de_personas = {
    84: 113, 128: 148, 39: 24, 65: 148, 121: 44, 21: 121, 115: 116, 117: 95, 29: 65,
    144: 64, 22: 84, 141: 30, 142: 98, 83: 78, 24: 8, 132: 144, 120: 52, 48: 130,
    82: 135, 150: 28, 28: 107, 131: 31, 109: 124, 92: 53, 60: 130, 100: 90, 45: 80,
    111: 49, 74: 138, 97: 64, 57: 52, 69: 70, 68: 108, 51: 115, 40: 48, 85: 137,
    72: 35, 50: 125, 49: 145, 44: 4, 126: 80, 147: 136, 106: 50, 80: 114, 5: 48,
    79: 12, 62: 114, 148: 131, 26: 43, 136: 45, 140: 31, 35: 9, 118: 59, 19: 85,
    34: 111, 55: 88, 59: 27, 52: 19, 104: 55, 78: 12, 67: 48, 2: 74, 123: 93,
    31: 66, 75: 91, 94: 86, 33: 64, 130: 93, 3: 123, 149: 94, 110: 96, 90: 77,
    1: 32, 119: 55, 71: 18, 102: 133, 61: 32, 98: 54, 107: 73, 25: 134, 86: 95,
    116: 99, 38: 52, 125: 64, 64: 16, 17: 115, 146: 127, 135: 117, 4: 20
}

ediciones_dict = {
    1: Edicion1,
    2: Edicion2,
    3: Edicion3,
    4: Edicion4,
    5: Edicion5,
    6: Edicion6
}

# ------------------------------
# GENERAR INSERCIONES
# ------------------------------

print("-- INSERTS para InscripcionTorneoDistancia\n")

inscritos_por_edicion = {}
entrenadores_por_participante = {}

for ed, participantes in ediciones_dict.items():

    IdTorneo = ed  # coincide EXACTO con la edición

    # número aleatorio de participantes a inscribir
    n = random.randint(10, 25)
    elegidos = random.sample(participantes, n)

    inscritos_por_edicion[ed] = []

    for p in elegidos:
        if p not in cuentas_de_personas:
            continue

        codigo = cuentas_de_personas[p]
        entrenadores_por_participante[p] = codigo
        inscritos_por_edicion[ed].append(p)

        print(
            f"INSERT INTO InscripcionTorneoDistancia "
            f"(Edicion, IdTorneo, IdPersona, CodigoDeEntrenador) "
            f"VALUES ({ed}, {IdTorneo}, {p}, {codigo});"
        )

# ------------------------------
# IMPRIMIR DICCIONARIOS EN PYTHON
# ------------------------------

print("\n\n# --------- DICCIONARIO inscritos_por_edicion ---------")
print("inscritos_por_edicion = {")
for ed, lista in inscritos_por_edicion.items():
    print(f"    {ed}: {lista},")
print("}")

print("\n# --------- DICCIONARIO entrenadores_por_participante ---------")
print("entrenadores_por_participante = {")
for p, cod in entrenadores_por_participante.items():
    print(f"    {p}: {cod},")
print("}")



for ed, participantes in ediciones_dict.items():

    IdTorneo = ed  # coincide EXACTO con la edición

    # número aleatorio de participantes a inscribir
    n = random.randint(10, 25)
    elegidos = random.sample(participantes, n)

    inscritos_por_edicion[ed] = []

    for p in elegidos:
        if p not in cuentas_de_personas:
            continue

        codigo = cuentas_de_personas[p]
        entrenadores_por_participante[p] = codigo
        inscritos_por_edicion[ed].append(p)

        print(
            f"INSERT INTO InscripcionTorneoCaptura "
            f"(Edicion, IdTorneo, IdPersona, CodigoDeEntrenador) "
            f"VALUES ({ed}, {IdTorneo}, {p}, {codigo});"
        )
