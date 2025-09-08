from dataclasses import dataclass
from typing import List, Optional
from datetime import datetime, date
from domain.entities.enums.sexo import Sexo

@dataclass
class Participante:
    """
    Entidad Participante
    """

    def __init__(self, nombre: str, apellido_pat: str, apellido_mat: str,
                 fecha_nac: str, edad: int, sexo: str,
                 telefonos: List[int],
                 correos: Optional[List[str]] = None,
                 numero_cuenta: int = 0, facultad: str = "", carrera: str = ""):

        self.nombre = nombre
        self.apellido_pat = apellido_pat
        self.apellido_mat = apellido_mat
        self.fecha_nac = (datetime.strptime(fecha_nac, "%d-%m-%Y").date()
                          if isinstance(fecha_nac, str) and fecha_nac else None)
        self.edad = edad
        self.sexo = Sexo(sexo) if isinstance(sexo, str) else sexo
        self.telefonos = telefonos or []
        self.correos = correos or []
        self.numero_cuenta = numero_cuenta
        self.facultad = facultad
        self.carrera = carrera

    def to_dict(self) -> dict:
        return {
            'nombre': self.nombre,
            'apellido_pat': self.apellido_pat,
            'apellido_mat': self.apellido_mat,
            'fecha_nac': self.fecha_nac.strftime("%d-%m-%Y") if self.fecha_nac else "",
            'edad': self.edad,
            'sexo': self.sexo.value if self.sexo else "",
            'telefonos': ';'.join(str(t) for t in self.telefonos), 
            'correos': ';'.join(self.correos),
            'numero_cuenta': self.numero_cuenta,
            'facultad': self.facultad,
            'carrera': self.carrera
        }
