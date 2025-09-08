"""
Entidad Pokémon
"""

from dataclasses import dataclass

from domain.entities.enums.sexo import Sexo
@dataclass
class Pokemon:
    """
    Entidad Pokémon
    """
    nombre: str
    especie: str
    tipo: str
    cp: int
    peso: float
    sexo: Sexo
    shiny: bool