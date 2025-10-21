from enum import Enum

class Sexo(Enum):
    """
    Enumeración para representar el género de un participante o Pokémon.

    Attributes:
        MASCULINO (str): Representa el género masculino.
        FEMENINO (str): Representa el género femenino.
        OTRO (str): Representa otros géneros o no especificado.
    """
    MASCULINO = "M"
    FEMENINO  = "F"
    OTRO      = "O"
    