from domain.entities.pokemon import Pokemon
from domain.entities.enums.sexo import Sexo
from domain.repositories.i_pokemon_repository import IPokemonRepository
from utils.exceptions.exceptions import EntityNotFoundException, ValidationException

class PokemonService:
    """
    Servicio para los Pokémon.
    Permite crear, actualizar, eliminar y consultar Pokémon.
    """

    def __init__(self, repository: IPokemonRepository):
        """
        Inicializa el servicio con un repositorio de Pokémon.

        Args:
            repository (IPokemonRepository): Repositorio de Pokémon.
        """
        self.repository = repository

    def add_pokemon(self, nombre: str, especie: str, tipo: str, cp: int, peso: float, sexo: Sexo, shiny: bool) -> Pokemon:
        """
        Crea y guarda un nuevo Pokémon en el repositorio.

        Args:
            nombre (str): Nombre o apodo del Pokémon.
            especie (str): Especie del Pokémon.
            tipo (str): Tipo del Pokémon.
            cp (int): Puntos de combate.
            peso (float): Peso del Pokémon.
            sexo (Sexo): Sexo del Pokémon.
            shiny (bool): Si es shiny.

        Returns:
            Pokemon: El Pokémon creado y guardado.
        """
        pokemon = Pokemon(
            _pokemon_id=None,  
            _nombre=nombre,
            _especie=especie,
            _tipo=tipo,
            _cp=cp,
            _peso=peso,
            _sexo=sexo,
            _shiny=shiny
        )
        self.repository.save(pokemon)
        return pokemon

    def get_pokemon(self, pokemon_id: int) -> Pokemon:
        """
        Recupera un Pokémon por su ID.

        Args:
            pokemon_id (int): Identificador único del Pokémon.

        Returns:
            Pokemon: El Pokémon encontrado.

        Raises:
            EntityNotFoundException: Si el Pokémon no existe.
        """
        pokemon = self.repository.find_by_pokemon_id(pokemon_id)
        if pokemon is None:
            raise EntityNotFoundException(f"No se encontró el Pokémon con ID {pokemon_id}.")
        return pokemon

    def get_all_pokemons(self) -> list[Pokemon]:
        """
        Recupera todos los Pokémon registrados.

        Returns:
            list[Pokemon]: Lista de todos los Pokémon.
        """
        return self.repository.all()

    def update_pokemon(self, pokemon_id: int, nombre: str, especie: str, tipo: str, cp: int, peso: float, sexo: Sexo, shiny: bool) -> Pokemon:
        """
        Actualiza los datos de un Pokémon existente.

        Args:
            pokemon_id (int): Identificador único del Pokémon.
            nombre (str): Nuevo nombre.
            especie (str): Nueva especie.
            tipo (str): Nuevo tipo.
            cp (int): Nuevos puntos de combate.
            peso (float): Nuevo peso.
            sexo (Sexo): Nuevo sexo.
            shiny (bool): Si es shiny.

        Returns:
            Pokemon: El Pokémon actualizado.

        Raises:
            EntityNotFoundException: Si el Pokémon no existe.
        """
        p = self.repository.find_by_pokemon_id(pokemon_id)
        if p is None:
            raise EntityNotFoundException(f"No se puede actualizar, el Pokémon con ID {pokemon_id} no existe.")
        p.nombre = nombre
        p.especie = especie
        p.tipo = tipo
        p.cp = cp
        p.peso = peso
        p.sexo = sexo
        p.shiny = shiny
        self.repository.update(p)
        return p

    def delete_pokemon(self, pokemon_id: int) -> None:
        """
        Elimina un Pokémon por su ID.

        Args:
            pokemon_id (int): ID del Pokémon a eliminar.

        Raises:
            EntityNotFoundException: Si el Pokémon no existe.
        """
        p = self.repository.find_by_pokemon_id(pokemon_id)
        if p is None:
            raise EntityNotFoundException(f"No se puede eliminar, el Pokémon con ID {pokemon_id} no existe.")
        self.repository.delete(pokemon_id)
