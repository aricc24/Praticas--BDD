from enumeraciones.consultas import Consultas
from enumeraciones.entidades import Entidades
from infrastructure.repositories.csv_participante_repository import ParticipanteRepositoryCSV

from application.services.participante_service import ParticipanteService
from presentation.menu import Menu

from infrastructure.repositories.csv_cuenta_repository import CuentaRepositoryCSV
from application.services.cuenta_service import CuentaService
from utils.validators.validators import validate_integer, validate_string, validate_date, validate_sexo, validate_int_list, validate_list, validate_equipo

class CLI:
    def __init__(self):
        self.participant_service = ParticipanteService(ParticipanteRepositoryCSV('data/participants.csv'))
        self.cuenta_service = CuentaService(CuentaRepositoryCSV('data/cuentas.csv'))
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

    def update_participant(self):
        print("¿A quien quieres modificar?")
        while True:
            try:
                numero_cuenta = validate_integer(input("Ingrese el número de cuenta del participante a modificar: "), "Número de Cuenta")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
    
        print(f"¿Qué campo deseas modificar ?")
        print("1. Nombre")
        print("2. Apellido Paterno")
        print("3. Apellido Materno")
        print("4. Fecha de Nacimiento")
        print("5. Edad")
        print("6. Sexo")
        print("7. Teléfonos")
        print("8. Correos")
        print("9. Número de Cuenta")
        print("10. Facultad")
        print("11. Carrera")
        print("12. Cancelar")
        while True:
            try:
                choice = validate_integer(input("Ingrese el número del campo a modificar: "), "Opción")
                if choice == 12:
                    print("Modificación cancelada.")
                    return
                if choice < 1 or choice > 12:
                    raise ValueError("Opción inválida.")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        field_map = {
            1: "nombre",
            2: "apellido_pat",
            3: "apellido_mat",
            4: "fecha_nac",
            5: "edad",
            6: "sexo",
            7: "telefonos",
            8: "correos",
            9: "numero_cuenta",
            10: "facultad",
            11: "carrera"
        }
        field_name = field_map[choice]
        while True:
            try:
                if field_name in ["nombre", "apellido_pat", "apellido_mat", "facultad", "carrera"]:
                    new_value = validate_string(input(f"Ingrese el nuevo valor para {field_name}: "), field_name)
                elif field_name == "fecha_nac":
                    new_value = validate_date(input(f"Ingrese el nuevo valor para {field_name} (DD-MM-YYYY): "), field_name)
                elif field_name in ["edad", "numero_cuenta"]:
                    new_value = validate_integer(input(f"Ingrese el nuevo valor para {field_name}: "), field_name)
                elif field_name == "sexo":
                    new_value = validate_sexo(input(f"Ingrese el nuevo valor para {field_name} (M/F/O): "), field_name)
                elif field_name == "telefonos":
                    new_value = validate_int_list(input(f"Ingrese los nuevos teléfonos (separados por comas): "), field_name)
                elif field_name == "correos":
                    new_value = validate_list(input(f"Ingrese los nuevos correos (separados por comas): "), field_name)
                else:
                    print("Campo no válido.")
                    return
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        modificado = self.participant_service.update_participante(numero_cuenta, **{field_name: new_value})
        if modificado:
            print("Participante modificado exitosamente.")
        else:
            print("Participante no encontrado.")

    def delete_participant(self):
        while True:
            try:
                numero_cuenta = validate_integer(input("Ingrese el número de cuenta del participante a eliminar: "), "Número de Cuenta")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        eliminado = self.participant_service.delete_participante(numero_cuenta)
        if eliminado:
            print("Participante eliminado")
        else:
            print("Participante no encontrado")

    def retrieve_participant(self):
        while True:
            try:
                numero_cuenta = validate_integer(input("Ingrese el número de cuenta del participante a consultar: "), "Número de Cuenta")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        participante = self.participant_service.get_by_numero_cuenta(numero_cuenta)
        if participante:
            print("Información del Participante:")
            for key, value in participante.to_dict().items():
                print(f"{key}: {value}")
        else:
            print("Participante no encontrado.")
        

    def handle_choice(self, choice: Consultas, entity: Entidades):
        handlers = {
            (Consultas.AGREGAR, Entidades.PARTICIPANTE): self.add_participant,
            (Consultas.EDITAR, Entidades.PARTICIPANTE): self.update_participant,
            (Consultas.ELIMINAR, Entidades.PARTICIPANTE): self.delete_participant,
            (Consultas.CONSULTAR, Entidades.PARTICIPANTE): self.retrieve_participant, 
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