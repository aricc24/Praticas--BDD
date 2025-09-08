
from typing import List, Optional, Union
from datetime import datetime, date
from domain.entities.enums.sexo import Sexo
from datetime import datetime, date


class Participante:
    def __init__(self, nombre: str, apellido_pat: str, apellido_mat: str,
                 fecha_nac:  date, sexo:  Sexo,
                 telefonos: List[int],
                 correos: Optional[List[str]] = None,
                 numero_cuenta: int = 0, facultad: str = "", carrera: str = ""):

        self.nombre = nombre
        self.apellido_pat = apellido_pat
        self.apellido_mat = apellido_mat
        self.fecha_nac = fecha_nac
        self.edad = self.calcular_edad()
        self.sexo = sexo
        self.telefonos = telefonos or []
        self.correos = correos or []
        self.numero_cuenta = numero_cuenta
        self.facultad = facultad
        self.carrera = carrera

    def calcular_edad(self) -> int:
        if not self.fecha_nac:
            return 0
        today = date.today()
        edad = today.year - self.fecha_nac.year - ((today.month, today.day) < (self.fecha_nac.month, self.fecha_nac.day))
        return edad
    
    @property
    def nombre(self) -> str:
        return self._nombre

    @nombre.setter
    def nombre(self, value: str):
        self._nombre = str(value).strip()

    @property
    def apellido_pat(self) -> str:
        return self._apellido_pat

    @apellido_pat.setter
    def apellido_pat(self, value: str):
        self._apellido_pat = str(value).strip()

    @property
    def apellido_mat(self) -> str:
        return self._apellido_mat

    @apellido_mat.setter
    def apellido_mat(self, value: str):
        self._apellido_mat = str(value).strip()

    @property
    def fecha_nac(self) -> date:
        return self._fecha_nac

    @fecha_nac.setter
    def fecha_nac(self, value: Union[str, date, None]):
        if isinstance(value, str) and value:
            self._fecha_nac = datetime.strptime(value, "%d-%m-%Y").date()
        elif isinstance(value, date):
            self._fecha_nac = value
        else:
            self._fecha_nac = None

    @property
    def edad(self) -> int:
        self._edad = self.calcular_edad()
        return self._edad

    @edad.setter
    def edad(self, value: Union[str, int]):
        self._edad = int(value) if value is not None else 0

    @property
    def sexo(self) -> Optional[Sexo]:
        return self._sexo

    @sexo.setter
    def sexo(self, value: Union[str, Sexo, None]):
        if isinstance(value, Sexo):
            self._sexo = value
        elif isinstance(value, str) and value:
            self._sexo = Sexo(value)   # convierte siempre a enum
        else:
            self._sexo = None

    @property
    def telefonos(self) -> List[int]:
        return self._telefonos

    @telefonos.setter
    def telefonos(self, value: List[Union[str, int]]):
        self._telefonos = [int(t) for t in value] if value else []

    @property
    def correos(self) -> List[str]:
        return self._correos

    @correos.setter
    def correos(self, value: List[str]):
        self._correos = [str(c).strip() for c in value] if value else []

    @property
    def numero_cuenta(self) -> int:
        return self._numero_cuenta

    @numero_cuenta.setter
    def numero_cuenta(self, value: int):
        if value is None:
            self._numero_cuenta = 0
        else:
            self._numero_cuenta = int(value)

    @property
    def facultad(self) -> str:
        return self._facultad

    @facultad.setter
    def facultad(self, value: str):
        self._facultad = str(value).strip()

    @property
    def carrera(self) -> str:
        return self._carrera

    @carrera.setter
    def carrera(self, value: str):
        self._carrera = str(value).strip()


    def to_dict(self) -> dict:
        return {
            'nombre': self.nombre,
            'apellido_pat': self.apellido_pat,
            'apellido_mat': self.apellido_mat,
            'fecha_nac': self.fecha_nac.strftime("%d-%m-%Y") if self.fecha_nac else "",
            'edad': self.edad,
            'sexo': self.sexo.value if self.sexo else "",
            'telefonos': ';'.join(map(str, self.telefonos)),
            'correos': ';'.join(self.correos),
            'numero_cuenta': self.numero_cuenta,
            'facultad': self.facultad,
            'carrera': self.carrera
        }

    @staticmethod
    def from_dict(data: dict) -> 'Participante':
        telefonos_raw = str(data.get('telefonos') or "")
        correos_raw = str(data.get('correos') or "")

        telefonos = [int(t) for t in telefonos_raw.split(';') if t.isdigit()]
        correos = [c for c in correos_raw.split(';') if c]

        return Participante(
            nombre=data.get('nombre', ''),
            apellido_pat=data.get('apellido_pat', ''),
            apellido_mat=data.get('apellido_mat', ''),
            fecha_nac=data.get('fecha_nac', ''), 
            sexo=data.get('sexo', ''),
            telefonos=telefonos,
            correos=correos,
            numero_cuenta=data.get('numero_cuenta', 0),
            facultad=data.get('facultad', ''),
            carrera=data.get('carrera', '')
        )