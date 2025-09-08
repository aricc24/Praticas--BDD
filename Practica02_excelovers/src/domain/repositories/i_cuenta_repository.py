"""
Cuenta Repository Interface.
Define el contrato para el acceso a datos de las cuentas.
"""

from abc import ABC, abstractmethod
from domain.entities.cuenta import Cuenta
class CuentaRepository(ABC):
    @abstractmethod
    def save(self, c: Cuenta): pass

    @abstractmethod
    def find_by_nombre_usuario(self, codigo_entrenador: int) -> Cuenta | None: pass

    @abstractmethod
    def update(self, c: Cuenta): pass

    @abstractmethod
    def delete(self, codigo_entrenador: int): pass

    @abstractmethod
    def all(self) -> list[Cuenta]: pass