from enumeraciones.consultas import Consultas
from enumeraciones.entidades import Entidades
from infrastructure.repositories.csv_participante_repository import ParticipanteRepositoryCSV

from application.services.participante_service import ParticipanteService
from presentation.menu import Menu
from utils.validators.validators import validate_integer, validate_string, validate_equipo

from infrastructure.repositories.csv_cuenta_repository import CuentaRepositoryCSV
from application.services.cuenta_service import CuentaService

class CLI:
    def __init__(self):
        self.participant_service = ParticipanteService(ParticipanteRepositoryCSV('data/participants.csv'))
        self.cuenta_service = CuentaService(CuentaRepositoryCSV('data/cuentas.csv'))
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

    def agrega_cuenta(self):
        print("\n--- Agregar Cuenta ---")
        codigo_entrenador = validate_integer(input("Código de entrenador: "), "Código de entrenador")
        nombre_usuario = validate_string(input("Nombre de usuario: "), "Nombre de usuario")
        nivel_entrenador = validate_integer(input("Nivel del entrenador: "), "Nivel de entrenador")
        equipo = validate_equipo(input("Equipo (Sabiduría, Instinto, Valor): "), "Equipo")
        cuenta = self.cuenta_service.add_cuenta(codigo_entrenador, nombre_usuario, nivel_entrenador, equipo)
        print(f"Cuenta creada exitosamente: {cuenta.nombre_usuario}")

    def consultar_cuenta(self):
        print("\n--- Consultar Cuenta ---")
        codigo_entrenador = validate_integer(input("Ingrese el código de entrenador: "), "Código de entrenador")
        cuenta = self.cuenta_service.get_cuenta(codigo_entrenador)
        print(f"Código: {cuenta.codigo_entrenador}, Usuario: {cuenta.nombre_usuario}, Nivel: {cuenta.nivel_entrenador}, Equipo: {cuenta.equipo.value}")

    def editar_cuenta(self):
        print("\n--- Editar Cuenta ---")
        codigo_entrenador = validate_integer(input("Ingrese el código de entrenador de la cuenta a editar: "), "Código de entrenador")
        nombre_usuario = validate_string(input("Nuevo nombre de usuario: "), "Nombre de usuario")
        nivel_entrenador = validate_integer(input("Nuevo nivel del entrenador: "), "Nivel de entrenador")
        equipo = validate_equipo(input("Nuevo equipo (Sabiduría, Instinto, Valor): "), "Equipo")
        cuenta = self.cuenta_service.update_cuenta(codigo_entrenador, nombre_usuario, nivel_entrenador, equipo)
        print(f"Cuenta actualizada exitosamente: {cuenta.nombre_usuario}")

    def eliminar_cuenta(self):
        print("\n--- Eliminar Cuenta ---")
        codigo_entrenador = validate_integer(input("Ingrese el código de entrenador de la cuenta a eliminar: "), "Código de entrenador")
        self.cuenta_service.delete_cuenta(codigo_entrenador)
        print(f"Cuenta con código {codigo_entrenador} eliminada exitosamente.")

    def handle_choice(self, choice: Consultas, entity: Entidades):
        handlers = {
            (Consultas.AGREGAR, Entidades.PARTICIPANTE): self.add_participant,
            (Consultas.AGREGAR, Entidades.CUENTA): self.agrega_cuenta,
            (Consultas.CONSULTAR, Entidades.CUENTA): self.consultar_cuenta,
            (Consultas.EDITAR, Entidades.CUENTA): self.editar_cuenta,
            (Consultas.ELIMINAR, Entidades.CUENTA): self.eliminar_cuenta,
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