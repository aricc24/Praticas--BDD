"""
Participante Repository
Define el contrato para el acceso a datos de los participantes.
"""

from abc import ABC, abstractmethod
from domain.entities.participante import Participante

class IParticipanteRepository(ABC):
    @abstractmethod
    def save(self, p: Participante): pass

    @abstractmethod
    def find_by_numero_cuenta(self, participante_id: str) -> Participante | None: pass

    @abstractmethod
    def update(self, p: Participante): pass

    @abstractmethod
    def delete(self, participante_id: str): pass

    @abstractmethod
    def all(self) -> list[Participante]: pass
