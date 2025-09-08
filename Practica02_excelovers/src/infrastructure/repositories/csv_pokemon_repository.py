from domain.entities.pokemon import Pokemon
from domain.repositories.i_pokemon_repository import IPokemonRepository
from infrastructure.file_handlers import CSVFileHandler

class PokemonRepositoryCSV(IPokemonRepository):
    """
    Implementación del repositorio de Pokémon utilizando archivos CSV.
    Proporciona métodos para guardar, buscar, actualizar y eliminar Pokémon
    en un archivo CSV.
    """

    def __init__(self, file_path: str):
        self.file_path = file_path
        self.file_handler = CSVFileHandler(
            file_path,
            [
                "pokemon_id",
                "nombre",
                "especie",
                "tipo",
                "cp",
                "peso",
                "sexo",
                "shiny",
            ],
        )

    def _get_next_id(self) -> int:
        """
        Obtiene el siguiente ID disponible para un nuevo Pokémon
        (simula un auto-increment de una base de datos).

        Returns:
            int: El siguiente ID disponible.
        """
        df = self.file_handler.read_data()
        if df.empty:
            return 1
        return int(df["pokemon_id"].max()) + 1

    def save(self, p: Pokemon) -> None:
        """
        Guarda un nuevo Pokémon en el repositorio.

        Args:
            p (Pokemon): El Pokémon a guardar.

        Returns:
            None
        """
        try:
            if p.pokemon_id is None: 
                p._pokemon_id = self._get_next_id()
            data = p.to_dict()
            self.file_handler.append_data(data)
        except Exception as e:
            raise Exception(f"Error al guardar el Pokémon: {e}")

    def find_by_pokemon_id(self, pokemon_id: int) -> Pokemon | None:
        """
        Busca un Pokémon en el repositorio a partir de su ID.

        Args:
            pokemon_id (int): El identificador único del Pokémon.

        Returns:
            Pokemon | None: El Pokémon encontrado o None si no existe.
        """
        try:
            df = self.file_handler.read_data()
            if df is None or df.empty:
                return None
            data = df[df["pokemon_id"] == pokemon_id]
            if data.empty:
                return None
            row = data.iloc[0].to_dict()
            return Pokemon.from_dict(row)
        except Exception as e:
            raise Exception(f"Error al buscar el Pokémon: {e}")

    def update(self, p: Pokemon) -> None:
        """
        Actualiza la información de un Pokémon existente.

        Args:
            p (Pokemon): El Pokémon con la información actualizada.

        Returns:
            None
        """
        try:
            df = self.file_handler.read_data()
            idx = df[df["pokemon_id"] == p.pokemon_id].index
            df.loc[idx[0]] = p.to_dict()
            self.file_handler.write_data(df)
        except Exception as e:
            raise Exception(f"Error al actualizar el Pokémon: {e}")

    def delete(self, pokemon_id: int) -> None:
        """
        Elimina un Pokémon del repositorio por su ID.

        Args:
            pokemon_id (int): Identificador del Pokémon a eliminar.

        Returns:
            None
        """
        try:
            df = self.file_handler.read_data()
            df = df[df["pokemon_id"] != pokemon_id]
            self.file_handler.write_data(df)
        except Exception as e:
            raise Exception(f"Error al eliminar el Pokémon: {e}")

    def all(self) -> list[Pokemon]:
        """
        Recupera todos los Pokémon almacenados en el repositorio.

        Returns:
            list[Pokemon]: Una lista de todos los Pokémon.
        """
        try:
            df = self.file_handler.read_data()
            if df is None or df.empty:
                return []
            pokemons = [Pokemon.from_dict(row) for _, row in df.iterrows()]
            return pokemons
        except Exception as e:
            raise Exception(f"Error al recuperar los Pokémon: {e}")
