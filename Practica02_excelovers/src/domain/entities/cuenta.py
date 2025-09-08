from dataclasses import dataclass
from domain.entities.enums.equipo_cuenta import EquipoCuenta

@dataclass
class Cuenta:
    """
    Cuenta que representa la información de la cuenta de un jugador en Pokémon Go.

    Attributes:
        codigo_entrenador (int): Código único del entrenador.
        nombre_usuario (str): Nombre de usuario de la cuenta.
        nivel_entrenador (int): Nivel numérico del entrenador.
        equipo (EquipoCuenta): Equipo al que pertenece el entrenador (Sabiduría, Instinto, Valor).
    """
    _codigo_entrenador: int
    _nombre_usuario: str
    _nivel_entrenador: int
    _equipo: EquipoCuenta

    @property
    def codigo_entrenador(self) -> int:
        """
        Obtiene el código del entrenador.

        Returns:
            int: Código del entrenador.
        """
        return self._codigo_entrenador

    # @codigo_entrenador.setter
    # def codigo_entrenador(self, value: int) -> None:
    #     """
    #     Establece el código del entrenador.

    #     Args:
    #         value (int): El nuevo código del entrenador.

    #     Returns:
    #         None
    #     """
    #     self._codigo_entrenador = value

    @property
    def nombre_usuario(self) -> str:
        """
        Obtiene el nombre de usuario de la cuenta.

        Returns:
            str: Nombre de usuario de la cuenta.
        """
        return self._nombre_usuario

    @nombre_usuario.setter
    def nombre_usuario(self, value: str) -> None:
        """
        Establece el nombre de usuario de la cuenta.

        Args:
            value (str): El nuevo nombre de usuario de la cuenta.

        Returns:
            None
        """
        self._nombre_usuario = value

    @property
    def nivel_entrenador(self) -> int:
        """
        Obtiene el nivel del entrenador.

        Returns:
            int: Nivel del entrenador.
        """
        return self._nivel_entrenador

    @nivel_entrenador.setter
    def nivel_entrenador(self, value: int) -> None:
        """
        Establece el nivel del entrenador.

        Args:
            value (int): El nuevo nivel del entrenador.

        Returns:
            None
        """
        self._nivel_entrenador = value

    @property
    def equipo(self) -> EquipoCuenta:
        """
        Obtiene el equipo al que pertenece el entrenador.
        Returns:
            EquipoCuenta: Equipo del entrenador.
        """
        return self._equipo

    @equipo.setter
    def equipo(self, value: EquipoCuenta) -> None:
        """
        Establece el equipo al que pertenece el entrenador.

        Args:
            value (EquipoCuenta): El nuevo equipo del entrenador.

        Returns:
            None
        """
        self._equipo = value

    def to_dict(self) -> dict:
        """
        Convierte la cuenta a un diccionario.

        Returns:
            dict: Diccionario con los atributos de la cuenta.
        """
        return {
            "codigo_entrenador": self._codigo_entrenador,
            "nombre_usuario": self._nombre_usuario,
            "nivel_entrenador": self._nivel_entrenador,
            "equipo": self._equipo.value
        }
    
    def from_dict(data: dict) -> 'Cuenta':
        """
        Crea una instancia de Cuenta a partir de un diccionario.

        Args:
            data (dict): Diccionario con los atributos de la cuenta.

        Returns:
            Cuenta: Instancia de Cuenta creada a partir del diccionario.
        """
        return Cuenta(
            _codigo_entrenador=data["codigo_entrenador"],
            _nombre_usuario=data["nombre_usuario"],
            _nivel_entrenador=data["nivel_entrenador"],
            _equipo=EquipoCuenta(data["equipo"])
        )
