"""
Cuenta Repository Interface.
Define el contrato para el acceso a datos de las cuentas.
"""

from abc import ABC, abstractmethod
from domain.entities.cuenta import Cuenta

class ICuentaRepository(ABC):
    """
    Interfaz del repositorio de Cuentas.
    Define las operaciones CRUD (Create, Read, Update, Delete)
    que cualquier implementación concreta del repositorio debe realizar.
    """

    @abstractmethod
    def save(self, c: Cuenta) -> None:
        """
        Guarda una nueva cuenta en el repositorio.

        Args:
            c (Cuenta): La cuenta a guardar.

        Returns:
            None
        """
        pass

    @abstractmethod
    def find_by_codigo_entrenador(self, codigo_entrenador: int) -> Cuenta | None:
        """
        Busca una cuenta en el repositorio a partir de su código de entrenador.

        Args:
            codigo_entrenador (int): El código único del entrenador asociado a la cuenta.

        Returns:
            Cuenta | None: La cuenta encontrada o None si no existe.
        """
        pass

    @abstractmethod
    def update(self, c: Cuenta) -> None:
        """
        Actualiza la información de una cuenta existente.

        Args:
            c (Cuenta): La cuenta con la información actualizada.

        Returns:
            None
        """
        pass

    @abstractmethod
    def delete(self, codigo_entrenador: int) -> None:
        """
        Elimina una cuenta del repositorio por su código de entrenador.

        Args:
            codigo_entrenador (int): El código del entrenador asociado a la cuenta a eliminar.

        Returns:
            None
        """
        pass

    @abstractmethod
    def all(self) -> list[Cuenta]:
        """
        Recupera todas las cuentas almacenadas en el repositorio.

        Returns:
            list[Cuenta]: Una lista de todas las cuentas.
        """
        pass