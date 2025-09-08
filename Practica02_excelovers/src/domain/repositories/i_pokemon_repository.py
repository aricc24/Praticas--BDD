from abc import ABC, abstractmethod
from domain.entities.pokemon import Pokemon

class IPokemonRepository(ABC):
    """
    Interfaz del repositorio de Pokémon.
    Define las operaciones CRUD (Create, Read, Update, Delete)
    que cualquier implementación concreta del repositorio debe realizar.
    """

    @abstractmethod
    def save(self, p: Pokemon) -> None:
        """
        Guarda un nuevo Pokémon en el repositorio.

        Args:
            p (Pokemon): El Pokémon a guardar.

        Returns:
            None
        """
        pass

    @abstractmethod
    def find_by_pokemon_id(self, pokemon_id: int) -> Pokemon | None:
        """
        Busca un Pokémon en el repositorio a partir de su identificador único.

        Args:
            pokemon_id (int): El identificador único del Pokémon.

        Returns:
            Pokemon | None: El Pokémon encontrado o None si no existe.
        """
        pass

    @abstractmethod
    def update(self, p: Pokemon) -> None:
        """
        Actualiza la información de un Pokémon existente.

        Args:
            p (Pokemon): El Pokémon con la información actualizada.

        Returns:
            None
        """
        pass

    @abstractmethod
    def delete(self, pokemon_id: int) -> None:
        """
        Elimina un Pokémon del repositorio por su identificador único.

        Args:
            pokemon_id (int): El identificador único del Pokémon a eliminar.

        Returns:
            None
        """
        pass