"""
Entidad Cuenta
"""

from dataclasses import dataclass
from domain.entities.enums.equipo_cuenta import EquipoCuenta

@dataclass
class Cuenta:
    """
    Entidad Cuenta
    """
    codigo_entrenador: int
    equipo: EquipoCuenta
    nivel: str
    nombre_usuario: str
    nivel_entrenador: int
