from enum import Enum

class Entidades(Enum):
    """
    Enumeración para representar las diferentes entidades en el sistema.

    Attributes:
        PARTICIPANTE (int): Representa la entidad de un participante.
        CUENTA (int): Representa la entidad de una cuenta.
        POKEMON (int): Representa la entidad de un Pokémon.
        SALIR (int): Representa la acción de salir del menú.
    """
    PARTICIPANTE = 1
    CUENTA = 2
    POKEMON = 3
    SALIR = 0
