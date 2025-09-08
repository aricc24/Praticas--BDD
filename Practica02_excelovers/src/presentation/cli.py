from enumeraciones.consultas import Consultas
from enumeraciones.entidades import Entidades
from infrastructure.repositories.csv_participante_repository import ParticipanteRepositoryCSV

from application.services.participante_service import ParticipanteService
from presentation.menu import Menu
from utils.validators.validators import validate_integer, validate_string

class CLI:
    def __init__(self):
        self.participant_service = ParticipanteService(ParticipanteRepositoryCSV('data/participants.csv'))
        self.running = True

    def add_participant(self):
        print("Agregar Participante")
        nombre = validate_string(input("Ingrese el nombre: "), "Nombre")
        apellido_pat = validate_string(input("Ingrese el apellido paterno: "), "Apellido Paterno")
        apellido_mat = validate_string(input("Ingrese el apellido materno: "), "Apellido Materno")
        # fecha_nac = validate_date(input("Ingrese la fecha de nacimiento (YYYY-MM-DD): "), "Fecha de Nacimiento")
        edad = validate_integer(input("Ingrese la edad: "), "Edad")
        # sexo = validate_sexo(input("Ingrese el sexo (M/F): "), "Sexo")
        # telefonos = validate_list(input("Ingrese los teléfonos (separados por comas): "), "Teléfonos")
        # correos = validate_list(input("Ingrese los correos (separados por comas): "), "Correos")
        numero_cuenta = validate_integer(input("Ingrese el número de cuenta: "), "Número de Cuenta")
        facultad = validate_string(input("Ingrese la facultad: "), "Facultad")
        carrera = validate_string(input("Ingrese la carrera: "), "Carrera")

        participante = self.participant_service.add_participante(
            nombre, apellido_pat, apellido_mat, None, edad, None, [], [], numero_cuenta, facultad, carrera
        )
        if participante:
            print("Participante agregado exitosamente.")
        else:
            print("Error al agregar el participante.")

    def handle_choice(self, choice: Consultas, entity: Entidades):
        handlers = {
            (Consultas.AGREGAR, Entidades.PARTICIPANTE): self.add_participant,
        }
        handler = handlers.get((choice, entity))
        if handler:
            handler()
        else:
            print("Funcionalidad no implementada aún :(")
    
    def run(self):
        while self.running:
            try:
                choice = Menu.get_operation_choice()
                if choice == Consultas.SALIR:
                    print("Saliendo... BYE :)!")
                    self.running = False
                    continue
                entity = Menu.get_entity_choice()
                if entity == Entidades.SALIR:
                    print("Volviendo al menú principal...")
                    continue
                self.handle_choice(choice, entity)
            except Exception as e:
                print(f"Error inesperado: {e}")