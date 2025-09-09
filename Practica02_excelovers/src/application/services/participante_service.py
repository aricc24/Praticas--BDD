from domain.repositories.i_participante_repository import IParticipanteRepository
from domain.entities.participante import Participante

class ParticipanteService:
    """
    Servicio para los participantes
    Permite guardar, obtener, modificar y eliminar participantes.
    """
    def __init__(self, repository: IParticipanteRepository):
        """
        Inicializa el servicio con un repositorio de participantes.

        Args:
            repository (IParticipanteRepository): Repositorio de participantes.
        """
        self.repository = repository

    def add_participante(self, nombre: str, apellido_pat: str, apellido_mat: str, fecha_nac: str,
                         sexo: str, telefonos: list[int], correos: list[str],
                         numero_cuenta: int, facultad: str, carrera: str) -> None:
        """
        Agrega un nuevo participante al sistema.
        Args:
            nombre (str): Nombre del participante.
            apellido_pat (str): Apellido paterno del participante.
            apellido_mat (str): Apellido materno del participante.
            fecha_nac (str): Fecha de nacimiento del participante.
            sexo (str): Sexo del participante.
            telefonos (list[int]): Lista de números de teléfono del participante.
            correos (list[str]): Lista de correos electrónicos del participante.
            numero_cuenta (int): Número de cuenta del participante.
            facultad (str): Facultad del participante.
            carrera (str): Carrera del participante.
        Returns:
            Participante: El participante creado.
        Raises:
            ValueError: Si el participante ya existe.
        """
    
        participante = self.repository.get_by_numero_cuenta(numero_cuenta)
        if participante:
            raise ValueError(f"El participante con número de cuenta {numero_cuenta} ya existe.")
        participante = Participante(
            nombre=nombre,
            apellido_pat=apellido_pat,
            apellido_mat=apellido_mat,
            fecha_nac=fecha_nac,
            sexo=sexo,
            telefonos=telefonos,
            correos=correos,
            numero_cuenta=numero_cuenta,
            facultad=facultad,
            carrera=carrera
        )
        self.repository.save(participante)
        return participante

    def get_by_numero_cuenta(self, numero_cuenta: int) -> Participante:
        """
        Obtiene un participante por su número de cuenta.
        Args:
            numero_cuenta (int): Número de cuenta del participante.
        Returns:
            Participante: El participante encontrado o None si no existe.
        """
        return self.repository.get_by_numero_cuenta(numero_cuenta)

    def update_participante(self, numero_cuenta: int, field:str, val:str) -> bool:
        """
        Obtiene un participante por su número de cuenta.
        Args:
            numero_cuenta (int): Número de cuenta del participante.
            field (str): Campo a modificar.
            val (str): Nuevo valor para el campo.
        Returns:
            bool: True si se actualizó correctamente, False si no se encontró el participante.
        """
        participante = self.repository.get_by_numero_cuenta(numero_cuenta)
       
        if not participante:
            return False
        if field == "numero_cuenta":
            self.delete_participante(participante.numero_cuenta)
            participante.numero_cuenta = val
            self.repository.save(participante)
            return True
        
        if hasattr(participante, field):
            setattr(participante, field, val)

        self.repository.update(participante)
        return True

    def delete_participante(self, numero_cuenta: int) -> bool:
        participante = self.repository.get_by_numero_cuenta(numero_cuenta)
        if not participante:
            return False
        self.repository.delete(numero_cuenta)
        return True