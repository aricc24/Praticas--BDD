from abc import ABC, abstractmethod
from domain.entities.participante import Participante

class IParticipanteRepository(ABC):
    """
    Interfaz del repositorio de Participantes.
    Define las operaciones CRUD (Create, Read, Update, Delete)
    que cualquier implementación concreta del repositorio debe realizar.
    """

    @abstractmethod
    def save(self, p: Participante) -> None:
        """
        Guarda un nuevo participante en el repositorio.

        Args:
            p (Participante): El participante a guardar.

        Returns:
            None
        """
        pass

    @abstractmethod
    def get_by_numero_cuenta(self, participante_id: int) -> Participante | None: 
        """
        Busca un participante por su número de cuenta.

        Args:
            participante_id (int): El número de cuenta del participante a buscar.

        Returns:
            Participante | None: El participante encontrado o None si no existe.
        """
        pass

    @abstractmethod
    def update(self, p: Participante) -> None:
        """
        Actualiza la información de un participante existente.

        Args:
            p (Participante): El participante con la información actualizada.

        Returns:
            None
        """
        pass

    @abstractmethod
    def delete(self, participante_id: int) -> None:
        """
        Elimina un participante del repositorio por su número de cuenta.

        Args:
            participante_id (int): El número de cuenta del participante a eliminar.

        Returns:
            None
        """
        pass
