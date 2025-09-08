from dataclasses import dataclass
from domain.entities.enums.sexo import Sexo

@dataclass
class Pokemon:
    """
    Pokémon que representa la información de un Pokémon registrado en el torneo.

    Attributes:
        pokemon_id (int): Identificador único del Pokémon.
        nombre (str): Nombre o apodo del Pokémon.
        especie (str): Especie del Pokémon.
        tipo (str): Tipo del Pokémon.
        cp (int): Puntos de combate del Pokémon.
        peso (float): Peso del Pokémon.
        sexo (Sexo): Sexo del Pokémon (Masculino, Femenino, N/A).
        shiny (bool): Indica si el Pokémon es shiny o no.
    """
    _pokemon_id: int
    _nombre: str
    _especie: str
    _tipo: str
    _cp: int
    _peso: float
    _sexo: Sexo
    _shiny: bool

    @property
    def pokemon_id(self) -> int:
        """
        Obtiene el identificador único del Pokémon.

        Returns:
            int: Identificador del Pokémon.
        """
        return self._pokemon_id

    # @pokemon_id.setter
    # def pokemon_id(self, value: int) -> None:
    #     """
    #     Establece el identificador único del Pokémon.

    #     Args:
    #         value (int): Nuevo identificador del Pokémon.

    #     Returns:
    #         None
    #     """
    #     self._pokemon_id = value

    @property
    def nombre(self) -> str:
        """
        Obtiene el nombre o apodo del Pokémon.

        Returns:
            str: Nombre del Pokémon.
        """
        return self._nombre

    @nombre.setter
    def nombre(self, value: str) -> None:
        """
        Establece el nombre o apodo del Pokémon.

        Args:
            value (str): Nuevo nombre del Pokémon.

        Returns:
            None
        """
        self._nombre = value

    @property
    def especie(self) -> str:
        """
        Obtiene la especie del Pokémon.

        Returns:
            str: Especie del Pokémon.
        """
        return self._especie

    @especie.setter
    def especie(self, value: str) -> None:
        """
        Establece la especie del Pokémon.

        Args:
            value (str): Nueva especie del Pokémon.

        Returns:
            None
        """
        self._especie = value

    @property
    def tipo(self) -> str:
        """
        Obtiene el tipo del Pokémon.

        Returns:
            str: Tipo del Pokémon.
        """
        return self._tipo

    @tipo.setter
    def tipo(self, value: str) -> None:
        """
        Establece el tipo del Pokémon.

        Args:
            value (str): Nuevo tipo del Pokémon.

        Returns:
            None
        """
        self._tipo = value

    @property
    def cp(self) -> int:
        """
        Obtiene los puntos de combate del Pokémon.

        Returns:
            int: Puntos de combate del Pokémon.
        """
        return self._cp

    @cp.setter
    def cp(self, value: int) -> None:
        """
        Establece los puntos de combate del Pokémon.

        Args:
            value (int): Nuevos puntos de combate.

        Returns:
            None
        """
        self._cp = value

    @property
    def peso(self) -> float:
        """
        Obtiene el peso del Pokémon.

        Returns:
            float: Peso del Pokémon.
        """
        return self._peso

    @peso.setter
    def peso(self, value: float) -> None:
        """
        Establece el peso del Pokémon.

        Args:
            value (float): Nuevo peso del Pokémon.

        Returns:
            None
        """
        self._peso = value

    @property
    def sexo(self) -> Sexo:
        """
        Obtiene el sexo del Pokémon.

        Returns:
            Sexo: Sexo del Pokémon.
        """
        return self._sexo

    @sexo.setter
    def sexo(self, value: Sexo) -> None:
        """
        Establece el sexo del Pokémon.

        Args:
            value (Sexo): Nuevo sexo del Pokémon.

        Returns:
            None
        """
        self._sexo = value

    @property
    def shiny(self) -> bool:
        """
        Indica si el Pokémon es shiny.

        Returns:
            bool: True si es shiny, False en caso contrario.
        """
        return self._shiny

    @shiny.setter
    def shiny(self, value: bool) -> None:
        """
        Establece si el Pokémon es shiny.

        Args:
            value (bool): True si es shiny, False en caso contrario.

        Returns:
            None
        """
        self._shiny = value

    def to_dict(self) -> dict:
        """
        Convierte el Pokémon a un diccionario.

        Returns:
            dict: Diccionario con los atributos del Pokémon.
        """
        return {
            "pokemon_id": self._pokemon_id,
            "nombre": self._nombre,
            "especie": self._especie,
            "tipo": self._tipo,
            "cp": self._cp,
            "peso": self._peso,
            "sexo": self._sexo.value,
            "shiny": self._shiny
        }
