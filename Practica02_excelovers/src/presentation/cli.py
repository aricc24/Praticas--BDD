from application.services.cuenta_service import CuentaService
from application.services.participante_service import ParticipanteService
from application.services.pokemon_service import PokemonService

from enumeraciones.consultas import Consultas
from enumeraciones.entidades import Entidades

from infrastructure.repositories.csv_cuenta_repository import CuentaRepositoryCSV
from infrastructure.repositories.csv_participante_repository import ParticipanteRepositoryCSV
from infrastructure.repositories.csv_pokemon_repository import PokemonRepositoryCSV

from presentation.handlers.cuenta_handler import CuentaHandler
from presentation.handlers.participante_handler import ParticipanteHandler
from presentation.handlers.pokemon_handler import PokemonHandler

from presentation.menu import Menu

class CLI:
    def __init__(self):
        self.running = True
        # Servicios
        self.participant_service = ParticipanteService(ParticipanteRepositoryCSV('data/participants.csv'))
        self.cuenta_service = CuentaService(CuentaRepositoryCSV('data/cuentas.csv'))
        self.pokemon_service = PokemonService(PokemonRepositoryCSV('data/pokemons.csv'))
        # Handlers
        self.participante_handler = ParticipanteHandler(self.participant_service)
        self.cuenta_handler = CuentaHandler(self.cuenta_service)
        self.pokemon_handler = PokemonHandler(self.pokemon_service)
        # Diccionario de handlers
        self.handlers = {
            (Consultas.AGREGAR, Entidades.PARTICIPANTE): self.participante_handler.add_participant,
            (Consultas.EDITAR, Entidades.PARTICIPANTE): self.participante_handler.update_participant,
            (Consultas.ELIMINAR, Entidades.PARTICIPANTE): self.participante_handler.delete_participant,
            (Consultas.CONSULTAR, Entidades.PARTICIPANTE): self.participante_handler.retrieve_participant,

            (Consultas.AGREGAR, Entidades.CUENTA): self.cuenta_handler.add_cuenta,
            (Consultas.EDITAR, Entidades.CUENTA): self.cuenta_handler.update_cuenta,
            (Consultas.ELIMINAR, Entidades.CUENTA): self.cuenta_handler.delete_cuenta,
            (Consultas.CONSULTAR, Entidades.CUENTA): self.cuenta_handler.retrieve_cuenta,

            (Consultas.AGREGAR, Entidades.POKEMON): self.pokemon_handler.add_pokemon,
            (Consultas.EDITAR, Entidades.POKEMON): self.pokemon_handler.update_pokemon,
            (Consultas.ELIMINAR, Entidades.POKEMON): self.pokemon_handler.delete_pokemon,
            (Consultas.CONSULTAR, Entidades.POKEMON): self.pokemon_handler.retrieve_pokemon,
        }

    def handle_choice(self, choice: Consultas, entity: Entidades) -> None:
        """
        Maneja la elección del usuario llamando al handler correspondiente.
        Args:
            choice (Consultas): La operación elegida por el usuario.
            entity (Entidades): La entidad sobre la que se realizará la operación.

        Returns:
            None
        """
        handler = self.handlers.get((choice, entity))
        if handler:
            handler()
        else:
            print("Funcionalidad no implementada aún :(")
    
    def run(self) -> None:
        """
        Inicializa la interfaz de línea de comandos y maneja el flujo principal del programa.

        Returns:
            None
        """
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
                print(f"Upsi!: {e}")