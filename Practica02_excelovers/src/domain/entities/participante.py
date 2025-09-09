"""
Módulo que define la entidad Participante para el sistema de torneo de Pokemon Go.

Este módulo contiene la clase Participante que representa a un jugador
registrado en el torneo, con todas sus informaciones personales y de contacto.
"""

from typing import List, Optional, Union
from datetime import datetime, date
from domain.entities.enums.sexo import Sexo
from datetime import datetime, date


class Participante:
    """
    Representa a un participante registrado en el torneo de Pokémon.
    Attributes:
        nombre (str): Nombre del participante
        apellido_pat (str): Apellido paterno del participante
        apellido_mat (str): Apellido materno del participante
        fecha_nac (date): Fecha de nacimiento del participante
        sexo (Sexo): Sexo del participante (enum)
        telefonos (List[int]): Lista de números telefónicos
        correos (List[str]): Lista de correos electrónicos
        numero_cuenta (int): Número de cuenta único del participante
        facultad (str): Facultad a la que pertenece el participante
        carrera (str): Carrera que estudia el participante
    """

    """
        Inicializa una nueva instancia de Participante.
    """
    def __init__(self, numero_cuenta:int, nombre: str, apellido_pat: str, apellido_mat: str,
                fecha_nac:  date, sexo:  Sexo,
                telefonos: List[int],
                correos: List[str],
                facultad: str, carrera: str ):

        self.nombre = nombre
        self.apellido_pat = apellido_pat
        self.apellido_mat = apellido_mat
        self.fecha_nac = fecha_nac
        self.sexo = sexo
        self.telefonos = telefonos or []
        self.correos = correos or []
        self.numero_cuenta = numero_cuenta
        self.facultad = facultad
        self.carrera = carrera
    
    @property
    def nombre(self) -> str:
        """
        Obtiene el nombre del participante.
        
        Returns:
            str: Nombre del participante
        """
        return self._nombre

    @nombre.setter
    def nombre(self, value: str):
        """
        Establece el nombre del participante.
        
        Args:
            value (str): Nuevo nombre para el participante
        """
        self._nombre = str(value).strip()

    @property
    def apellido_pat(self) -> str:
        """
        Obtiene el apellido paterno del participante.
        
        Returns:
            str: Apellido paterno del participante
        """
        return self._apellido_pat

    @apellido_pat.setter
    def apellido_pat(self, value: str):
        """
        Establece el apellido paterno del participante.
        
        Args:
            value (str): Nuevo apellido paterno para el participante
        """
        self._apellido_pat = str(value).strip()

    @property
    def apellido_mat(self) -> str:
        """
        Obtiene el apellido materno del participante.
        
        Returns:
            str: Apellido materno del participante.
        """
        return self._apellido_mat

    @apellido_mat.setter
    def apellido_mat(self, value: str):
        """
        Establece el apellido materno del participante.
        
        Args:
            value (str): Nuevo apellido materno para el participante
        """
        self._apellido_mat = str(value).strip()

    @property
    def fecha_nac(self) -> date:
        """
        Obtiene la fecha de nacimiento del participante.
        
        Returns:
            date: Fecha de nacimiento del participante.
        """
        return self._fecha_nac

    @fecha_nac.setter
    def fecha_nac(self, value: Union[str, date, None]):
        """
        Establece la fecha de nacimiento del participante.
        
        Args:
            value: Nueva fecha de nacimiento (puede ser string, date o None)
            
        Note: Si se proporciona un string, debe estar en formato "dd-mm-aaaa"
        """
        if isinstance(value, str) and value:
            self._fecha_nac = datetime.strptime(value, "%d-%m-%Y").date()
        elif isinstance(value, date):
            self._fecha_nac = value
        else:
            self._fecha_nac = None


    @property
    def sexo(self) -> Optional[Sexo]:
        """
        Obtiene el sexo del participante.
        
        Returns:
            Optional[Sexo]: Sexo del participante o None.
        """
        return self._sexo

    @sexo.setter
    def sexo(self, value: Union[str, Sexo, None]):
        """
        Establece el sexo del participante.
        
        Args:
            value: Nuevo sexo para el participante (puede ser string, enum Sexo o None)
        """
        if isinstance(value, Sexo):
            self._sexo = value
        elif isinstance(value, str) and value:
            self._sexo = Sexo(value)   # convierte siempre a enum
        else:
            self._sexo = None

    @property
    def telefonos(self) -> List[int]:
        """
        Obtiene la lista de números telefónicos del participante.
        
        Returns:
            List[int]: Lista de números telefónicos
        """
        return self._telefonos

    @telefonos.setter
    def telefonos(self, value:List[Union[str, int]]):
        """
        Establece la lista de números telefónicos.
        
        Args:
            value: Nueva lista de números telefónicos
        """
        self._telefonos = [int(t) for t in value] if value else []

    @property
    def correos(self) -> List[str]:
        """
        Obtiene la lista de correos electrónicos del participante.
        
        Returns:
            List[str]: Lista de correos electrónicos
        """
        return self._correos

    @correos.setter
    def correos(self, value: List[str]):
        """
        Establece la lista de correos electrónicos con validación.
        
        Args:
            value: Nueva lista de correos electrónicos
        """
        self._correos = [str(c).strip() for c in value] if value else []

    @property
    def numero_cuenta(self) -> int:
        """
        Obtiene el número de cuenta único del participante.
        
        Returns:
            int: Número de cuenta del participante
        """
        return self._numero_cuenta

    @numero_cuenta.setter
    def numero_cuenta(self, value: int):
        """
        Establece el número de cuenta del participante.
        
        Args:
            value: Nuevo número de cuenta para el participante
        """

        if value is None:
            self._numero_cuenta = 0
        else:
            self._numero_cuenta = int(value)

    @property
    def facultad(self) -> str:
        """
        Obtiene la facultad del participante.
        
        Returns:
            str: Facultad actual del participante
        """
        return self._facultad

    @facultad.setter
    def facultad(self, value: str):
        """
        Establece la facultad del participante.
        
        Args:
            value: Nueva facultad para el participante
        """
        self._facultad = str(value).strip()

    @property
    def carrera(self) -> str:
        """
        Obtiene la carrera del participante.
        
        Returns:
            str: Carrera actual del participante
        """
        return self._carrera

    @carrera.setter
    def carrera(self, value: str):
        """
        Establece la carrera del participante.
        
        Args:
            value: Nueva carrera para el participante
        """
        self._carrera = str(value).strip()

    def edad(self) -> int:
        """
        Calcula la edad actual del participante basándose en su fecha de nacimiento.
        
        Returns:
            int: Edad actual del participante en años
            
        Note:
            Retorna 0 si no hay fecha de nacimiento
        """
        if not self.fecha_nac:
            return 0
        today = date.today()
        edad = today.year - self.fecha_nac.year - ((today.month, today.day) < (self.fecha_nac.month, self.fecha_nac.day))
        return edad
    
    def to_dict(self) -> dict:
        """
        Convierte la instancia de Participante a un diccionario serializable.
        
        Returns:
            dict: Diccionario con todos los atributos del participante
                    en formato adecuado para almacenamiento
        """
        return {
            'numero_cuenta': self.numero_cuenta,
            'nombre': self.nombre,
            'apellido_pat': self.apellido_pat,
            'apellido_mat': self.apellido_mat,
            'fecha_nac': self.fecha_nac.strftime("%d-%m-%Y") if self.fecha_nac else "",
            'sexo': self.sexo.value if self.sexo else "",
            'telefonos': ';'.join(map(str, self.telefonos)),
            'correos': ';'.join(self.correos),
            'facultad': self.facultad,
            'carrera': self.carrera
        }

    @staticmethod
    def from_dict(data: dict) -> 'Participante':
        """
        Crea una instancia de Participante a partir de un diccionario.
        
        Args:
            data (dict): Diccionario con los datos del participante
            
        Returns:
            Participante: Nueva instancia de Participante creada a partir de los datos
        """
        telefonos_raw = str(data.get('telefonos') or "")
        correos_raw = str(data.get('correos') or "")

        if isinstance(telefonos_raw, str):
            telefonos = [int(t) for t in telefonos_raw.split(';') if t]
        else:
            telefonos = [telefonos_raw]
        if not isinstance(correos_raw, str):
            correos = [correos_raw]
        else:
            correos = [c for c in correos_raw.split(';') if c]

        return Participante(
            numero_cuenta=int(data.get('numero_cuenta', 0)),
            nombre=data.get('nombre', ''),
            apellido_pat=data.get('apellido_pat', ''),
            apellido_mat=data.get('apellido_mat', ''),
            fecha_nac=data.get('fecha_nac', ''), 
            sexo=data.get('sexo', ''),
            telefonos=telefonos,
            correos=correos,
            facultad=data.get('facultad', ''),
            carrera=data.get('carrera', '')
        )