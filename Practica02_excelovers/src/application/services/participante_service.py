from domain.repositories.i_participante_repository import IParticipanteRepository
from domain.entities.participante import Participante

class ParticipanteService:
    """
    Servicio para la gestión los participantes
    Permite guardar, obtener, modificar y eliminar participantes.
    """
    def __init__(self, repository: IParticipanteRepository):
        """
        Inicializa el servicio con un repositorio de participantes.

        Args:
            repository (IParticipanteRepository): Repositorio de participantes.
        """
        self.repository = repository

    """
        Crea y guarda un nuevo participante después de validar que no exista.
        Args:
            nombre (str): Nombre del participante
            apellido_pat (str): Apellido paterno
            apellido_mat (str): Apellido materno
            fecha_nac (str): Fecha de nacimiento en formato string
            sexo (str): Género del participante
            telefonos (list[int]): Lista de números telefónicos
            correos (list[str]): Lista de correos electrónicos
            numero_cuenta (int): Número de cuenta único identificador
            facultad (str): Facultad a la que pertenece
            carrera (str): Carrera que estudia

         Returns:
            Participante: El participante creado y guardado
            
        Raises:
            ValueError: Si ya existe un participante con el mismo número de cuenta
    """
    def add_participante(self, nombre: str, apellido_pat: str, apellido_mat: str, fecha_nac: str,
                         sexo: str, telefonos: list[int], correos: list[str],
                         numero_cuenta: int, facultad: str, carrera: str) -> None:
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

    """
        Recupera un participante por su número de cuenta.
        Args:
            numero_cuenta (int): Número de cuenta único del participante
            
        Returns:
            Participante: El participante encontrado o None si no existe
    """
    def get_by_numero_cuenta(self, numero_cuenta: int) -> Participante:
        return self.repository.get_by_numero_cuenta(numero_cuenta)

    """
        Actualiza un campo específico de un participante existente.
        Args:
            numero_cuenta (int): Número de cuenta del participante a actualizar
            field (str): Nombre del campo a modificar
            val (str): Nuevo valor para el campo
            
        Returns:
            bool: True si la actualización fue exitosa, False si el participante no existe
            
        Note:
            Para el campo 'numero_cuenta' se realiza una operación especial de 
            eliminación y recreación debido a su naturaleza de llave única.
    """
    def update_participante(self, numero_cuenta: int, field:str, val:str) -> bool:
       
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
    
    """
        Elimina un participante por su número de cuenta.
        Args:
            numero_cuenta (int): Número de cuenta único del participante a eliminar
            
        Returns:
            bool: True si la eliminación fue exitosa, False si el participante no existe
    """
    def delete_participante(self, numero_cuenta: int) -> bool:
        participante = self.repository.get_by_numero_cuenta(numero_cuenta)
        if not participante:
            return False
        self.repository.delete(numero_cuenta)
        return True