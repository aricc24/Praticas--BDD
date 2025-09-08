from enumeraciones.consultas import Consultas
from enumeraciones.entidades import Entidades

class Menu:
    @staticmethod
    def display_main_menu():
        print("Seleccione una opción:")
        print("1. Agregar")
        print("2. Consultar")
        print("3. Editar")
        print("4. Eliminar")
        print("0. Salir")
        
    @staticmethod
    def display_entity_menu():
        print("Seleccione una entidad:")
        print("1. Participante")
        print("2. Cuenta")
        print("3. Pokémon")
        print("0. Salir")

    @staticmethod
    def get_menu_option(prompt: str, valid_options: list[int]) -> int:
        while True:
            try:
                choice = int(input(prompt))
                if choice in valid_options:
                    return choice
                else:
                    print(f"Opción inválida. Por favor, elija entre {valid_options}.")
            except ValueError:
                print("Entrada inválida. Por favor, ingrese un número.")
        
    @staticmethod
    def get_operation_choice() -> Consultas:
        Menu.display_main_menu()
        choice = Menu.get_menu_option("Seleccione una opción: ", [0, 1, 2, 3, 4])
        return Consultas(choice)
    
    @staticmethod
    def get_entity_choice() -> Entidades:
        Menu.display_entity_menu()
        choice = Menu.get_menu_option("Seleccione una entidad: ", [0, 1, 2, 3])
        return Entidades(choice)
