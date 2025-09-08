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

    def from_dict(data: dict) -> 'Participante':
       
        telefonos_raw = data.get('telefonos', [])
        correos_raw = data.get('correos', [])

        telefonos = [int(t) for t in (telefonos_raw.split(';') if isinstance(telefonos_raw, str) else [telefonos_raw])]
        correos = [str(c) for c in (correos_raw.split(';') if isinstance(correos_raw, str) else [correos_raw])]

        return Participante(
            nombre=data.get('nombre', ''),
            apellido_pat=data.get('apellido_pat', ''),
            apellido_mat=data.get('apellido_mat', ''),
            fecha_nac=data.get('fecha_nac', ''),
            edad=int(data.get('edad', 0)),
            sexo=data.get('sexo', ''),
            telefonos=telefonos,
            correos=correos,
            numero_cuenta=int(data.get('numero_cuenta', 0)),
            facultad=data.get('facultad', ''),
            carrera=data.get('carrera', '')
        )