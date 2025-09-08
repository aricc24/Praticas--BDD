from enumeraciones.consultas import Consultas
from enumeraciones.entidades import Entidades

class Menu:
    @staticmethod
    def display_main_menu() -> None:
        """
        Muestra el menú principal de opciones.
        """
        print("Seleccione una opción:")
        print("1. Agregar")
        print("2. Consultar")
        print("3. Editar")
        print("4. Eliminar")
        print("0. Salir")
        
    @staticmethod
    def display_entity_menu() -> None:
        """
        Muestra el menú de entidades.
        """
        print("Seleccione una entidad:")
        print("1. Participante")
        print("2. Cuenta")
        print("3. Pokémon")
        print("0. Salir")

    @staticmethod
    def get_menu_option(prompt: str, valid_options: list[int]) -> int:
        """
        Solicita al usuario que seleccione una opción del menú.

        Args:
            prompt (str): El mensaje a mostrar al usuario.
            valid_options (list[int]): Lista de opciones válidas.

        Returns:
            int: La opción seleccionada por el usuario.
        """
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
        """
        Obtiene la opción de operación seleccionada por el usuario.

        Returns:
            Consultas: La opción de operación seleccionada.
        """
        Menu.display_main_menu()
        choice = Menu.get_menu_option("Seleccione una opción: ", [0, 1, 2, 3, 4])
        return Consultas(choice)
    
    @staticmethod
    def get_entity_choice() -> Entidades:
        """
        Obtiene la opción de entidad seleccionada por el usuario.

        Returns:
            Entidades: La opción de entidad seleccionada.
        """
        Menu.display_entity_menu()
        choice = Menu.get_menu_option("Seleccione una entidad: ", [0, 1, 2, 3])
        return Entidades(choice)
