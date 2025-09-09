from utils.validators.validators import (
    validate_integer, validate_date, validate_sexo,
    validate_correos, validate_input, validate_telefonos,
    validate_nombre_propio, validate_cuenta

)
from domain.entities.enums.sexo import Sexo



class ParticipanteHandler:
    """
    Clase encargada de manejar las operaciones relacionadas con los Participantes del lado del usuario.
        """
    def __init__(self, participante_service):
        """
        Inicializa el handler con un servicio de Participante.

        Args:
            participante_service: Servicio de Participante.
        """
        self.participant_service = participante_service

    def add_participant(self):
        """
        Maneja la adición de un nuevo Participante.
        """

        print("Agregar Participante")

        nombre = validate_input(input("Ingrese el nombre: "), validate_nombre_propio, "Nombre")

        apellido_pat = validate_input(input("Ingrese el apellido paterno: "), validate_nombre_propio, "Apellido Paterno")

        apellido_mat = validate_input(input("Ingrese el apellido materno: "), validate_nombre_propio, "Apellido Materno")

        fecha_nac = validate_input(input("Ingrese la fecha de nacimiento (DD-MM-YYYY): "), validate_date, "Fecha de Nacimiento")

        numero_cuenta = validate_input(input("Ingrese el número de cuenta: "), validate_cuenta, "Número de Cuenta")

        facultad = validate_input(input("Ingrese la facultad: "), validate_nombre_propio, "Facultad")
        carrera = validate_input(input("Ingrese la carrera: "), validate_nombre_propio, "Carrera")

        sexo = validate_input(input("Ingrese el sexo (M/F/O): "), validate_sexo, "Sexo")


        telefonos = validate_input(input("Ingrese los teléfonos (separados por comas): "), validate_telefonos, "Teléfonos")
        correos = validate_input(input("Ingrese los correos (separados por comas): "), validate_correos, "Correos")

        participante = self.participant_service.add_participante(
            nombre, apellido_pat, apellido_mat, fecha_nac, sexo, telefonos, correos, numero_cuenta, facultad, carrera
        )
        if participante:
            print("Participante agregado exitosamente.")
        else:
            print("Error al agregar el participante.")

    def update_participant(self):
        """
        Maneja la actualización de un Participante existente.
        """
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
        print("5. Sexo")
        print("6. Teléfonos")
        print("7. Correos")
        print("8. Número de Cuenta")
        print("9. Facultad")
        print("10. Carrera")
        print("11. Cancelar")
        while True:
            try:
                choice = validate_integer(input("Ingrese el número del campo a modificar: "), "Opción")
                if choice == 11:
                    print("Modificación cancelada.")
                    return
                if choice < 1 or choice > 11:
                    raise ValueError("Opción inválida.")
                break
            except ValueError as ve:
                print(f"Error: {ve}")
        field_map = {
            1: "nombre",
            2: "apellido_pat",
            3: "apellido_mat",
            4: "fecha_nac",
            5: "sexo",
            6: "telefonos",
            7: "correos",
            8: "numero_cuenta",
            9: "facultad",
            10: "carrera"
        }
        field_name = field_map[choice]
       
        try:
            if field_name in ["nombre", "apellido_pat", "apellido_mat", "facultad", "carrera"]:
                validate_input(input(f"Ingrese el nuevo valor para {field_name}: "), validate_nombre_propio, "Nombre")
            elif field_name == "fecha_nac":
                new_value = validate_input(input(f"Ingrese la nueva fecha de nacimiento (DD-MM-YYYY): "), validate_date, "Fecha de Nacimiento")
            elif field_name in ["numero_cuenta"]:
                new_value = validate_input(input(f"Ingrese el nuevo valor para {field_name}: "), validate_cuenta, "Número de Cuenta")
            elif field_name == "sexo":
                new_value = validate_input(input(f"Ingrese el nuevo valor para {field_name} (M/F/O): "), validate_sexo, "Sexo")
            elif field_name == "telefonos":
                new_value = validate_input(input(f"Ingrese los nuevos teléfonos (separados por comas): "), validate_telefonos, "Teléfonos")
            elif field_name == "correos":
                new_value = validate_input(input(f"Ingrese los nuevos correos (separados por comas): "), validate_correos, "Correos")
            else:
                print("Campo no válido.")
                return
        except ValueError as ve:
            print(f"Error: {ve}")
        modificado = self.participant_service.update_participante(numero_cuenta, field_name, new_value)
        if modificado:
            print("Participante modificado exitosamente.")
        else:
            print("Participante no encontrado.")

    def delete_participant(self):
        """
        Maneja la eliminación de un Participante existente.
        """
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
        """
        Maneja la consulta de un Participante existente.
        """
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
                if key== "sexo":
                    print(f"{key}: {Sexo(value).name.capitalize()}")
                else:
                    print(f"{key}: {value}")
            print(f"Edad: {participante.edad()} años")
        else:
            print("Participante no encontrado.")
        
