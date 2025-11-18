import random

# --------- DICCIONARIOS QUE NOS DISTE ---------
inscritos_por_edicion = {
    1: [144, 50, 26, 24, 118, 149],
    2: [57, 119, 115, 111, 146, 98],
    3: [2, 140, 31, 69, 29, 35, 131, 72, 117, 5],
    4: [85, 26, 64, 98, 94, 62, 35, 117, 4, 104, 140, 142, 125, 146, 45],
    5: [80, 49, 45, 85, 90, 84, 147, 140, 50, 117, 104, 69],
    6: [74, 60, 49, 131, 118, 110, 57, 31],
}

entrenadores_por_participante = {
    144: 64, 50: 125, 26: 43, 24: 8, 118: 59, 149: 94,
    57: 52, 119: 55, 115: 116, 111: 49, 146: 127, 98: 54,
    2: 74, 140: 31, 31: 66, 69: 70, 29: 65, 35: 9, 131: 31,
    72: 35, 117: 95, 5: 48, 85: 137, 64: 16, 94: 86, 62: 114,
    4: 20, 104: 55, 142: 98, 125: 64, 45: 80, 80: 114, 49: 145,
    90: 77, 84: 113, 147: 136, 74: 138, 60: 130, 110: 96,
}

# --------- CONFIG ---------
random.seed(42)
locaciones = ["Universum", "Entrada", "Rectoria"]


fechas_evento = {
    1: '2023-04-10',
    2: '2023-07-14',
    3: '2024-05-11',
    4: '2024-11-02',
    5: '2025-02-02',
    6: '2025-12-02'
}


def generar_hora():
    h = random.randint(7, 12)
    m = random.randint(0, 59)
    return f"{h:02d}:{m:02d}:00"

# --------- GENERACIÓN DE INSERTS ---------
print("-- INSERTS generados automáticamente")
print()

for id_evento, participantes in inscritos_por_edicion.items():

    for persona in participantes:
        entrenador = entrenadores_por_participante[persona]
        fecha = fechas_evento[id_evento]

        # Número aleatorio entre 3 y 6 por participante
        k = random.randint(3, 6)

        # Generar locaciones sin repetir consecutivas
        locs = []
        last = None
        for _ in range(k):
            choices = [l for l in locaciones if l != last]
            sel = random.choice(choices)
            locs.append(sel)
            last = sel

        # Crear registros
        iddist = 1
        for loc in locs:
            hora = generar_hora()

            print(
                f"INSERT INTO distanciarecorrida "
                f"(IdEvento, IdPersona, CodigoEntrenador, IdDistancia, Fecha, Hora, Locacion) "
                f"VALUES ({id_evento}, {persona}, {entrenador}, {iddist}, '{fecha}', '{hora}', '{loc}');"
            )

            iddist += 1

print("\n-- FIN")
