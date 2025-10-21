from enum import Enum

class Consultas(Enum):
    """
    Enumeración para representar las diferentes consultas disponibles en el sistema.
    
    Attributes:
        AGREGAR (int): Representa la acción de agregar un nuevo registro.
        CONSULTAR (int): Representa la acción de consultar registros existentes.
        EDITAR (int): Representa la acción de editar un registro existente.
        ELIMINAR (int): Representa la acción de eliminar un registro existente.
        SALIR (int): Representa la acción de salir del menú.
    """
    AGREGAR = 1
    CONSULTAR = 2
    EDITAR = 3
    ELIMINAR = 4
    SALIR = 0
