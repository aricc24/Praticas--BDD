from utils.validators.validators import validate_integer, validate_string, validate_equipo, validate_input

class CuentaHandler:
    def __init__(self, cuenta_service):
        self.cuenta_service = cuenta_service

    def add_cuenta(self):
        print("Agregar Cuenta")
        codigo = validate_integer(input("Código entrenador: "), "Código")
        usuario = validate_string(input("Usuario: "), "Usuario")
        nivel = validate_integer(input("Nivel: "), "Nivel")
        equipo = validate_equipo(input("Equipo (Sabiduría, Instinto, Valor): "), "Equipo")
        try:
            cuenta = self.cuenta_service.add_cuenta(codigo, usuario, nivel, equipo)
            print(f"Cuenta creada exitosamente: {cuenta.codigo_entrenador}")
        except Exception as e:
            print(f"Error al crear la cuenta: {e}")

    def retrieve_cuenta(self):
        print("Consultar Cuenta")
        codigo = validate_integer(input("Código entrenador: "), "Código")
        try:
            cuenta = self.cuenta_service.get_cuenta(codigo)
            if cuenta:
                print("Información de la Cuenta:")
                print(cuenta)
            else:
                print("Cuenta no encontrada.")
        except Exception as e:
            print(f"Error al consultar la cuenta: {e}")

    def delete_cuenta(self):
        print("Eliminar Cuenta")
        codigo = validate_integer(input("Código entrenador a eliminar: "), "Código")
        try:
            self.cuenta_service.delete_cuenta(codigo)
        except Exception as e:
            print(f"Error al eliminar la cuenta: {e}")

    def update_cuenta(self):
        print("Editar Cuenta")
        codigo = validate_integer(input("Código de entrenador a editar: "), "Código")
        try:
            cuenta = self.cuenta_service.get_cuenta(codigo)
        except Exception as e:
            print(f"No se encontró la cuenta: {e}")
            return
        usuario = validate_input(input(f"Usuario [{cuenta.nombre_usuario}]: "), lambda x, y: validate_string(x, y) if x.strip() else cuenta.nombre_usuario, "Usuario")
        nivel = validate_input(input(f"Nivel [{cuenta.nivel_entrenador}]: "), lambda x, y: validate_integer(x, y) if x.strip() else cuenta.nivel_entrenador, "Nivel")
        equipo = validate_input(input(f"Equipo (Sabiduría, Instinto, Valor) [{cuenta.equipo.value}]: "), lambda x, y: validate_equipo(x, y) if x.strip() else cuenta.equipo, "Equipo")
        try:
            cuenta_actualizada = self.cuenta_service.update_cuenta(
                codigo,
                usuario,
                nivel,
                equipo
            )
            print(f"Cuenta actualizada exitosamente: {cuenta_actualizada.codigo_entrenador}")
        except Exception as e:
            print(f"Error al actualizar la cuenta: {e}")