from enumeraciones.consultas import Consultas
from enumeraciones.entidades import Entidades
from infrastructure.repositories.csv_participante_repository import ParticipanteRepositoryCSV

from application.services.participante_service import ParticipanteService
from presentation.menu import Menu
from utils.validators.validators import validate_integer, validate_string, validate_date, validate_sexo, validate_int_list, validate_list

class CLI:
    def __init__(self):
        self.participant_service = ParticipanteService(ParticipanteRepositoryCSV('data/participants.csv'))
        self.running = True

    def add_participant(self):

        print("Agregar Participante")
        while True:
            try:
                nombre = validate_string(input("Ingrese el nombre: "), "Nombre")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        while True:
            try:
                apellido_pat = validate_string(input("Ingrese el apellido paterno: "), "Apellido Paterno")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        while True:
            try:
                apellido_mat = validate_string(input("Ingrese el apellido materno: "), "Apellido Materno")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        while True:
            try:
                fecha_nac = validate_date(input("Ingrese la fecha de nacimiento (DD-MM-YYYY): "), "Fecha de Nacimiento")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        while True:
            try:
                edad = validate_integer(input("Ingrese la edad: "), "Edad")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        while True:
            try:
                numero_cuenta = validate_integer(input("Ingrese el número de cuenta: "), "Número de Cuenta")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        while True:
            try:
                facultad = validate_string(input("Ingrese la facultad: "), "Facultad")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        while True:
            try:
                carrera = validate_string(input("Ingrese la carrera: "), "Carrera")
                break
            except ValueError as ve:
                print(f"Error: {ve}")   
        
        while True:
            try:
                sexo = validate_sexo(input("Ingrese el sexo (M/F/O): "), "Sexo")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        while True:
            try:
                telefonos = validate_int_list(input("Ingrese los teléfonos (separados por comas): "), "Teléfonos")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        while True:
            try:
                correos = validate_list(input("Ingrese los correos (separados por comas): "), "Correos")
                break
            except ValueError as ve:
                print(f"Error: {ve}")

        participante = self.participant_service.add_participante(
            nombre, apellido_pat, apellido_mat, fecha_nac, edad, sexo, telefonos, correos, numero_cuenta, facultad, carrera
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