class EntityNotFoundException(Exception):
    """
    Excepción cuando una entidad no es encontrada.
    Indica que la búsqueda no tuvo éxito.
    """
    pass

class ValidationException(Exception):
    """
    Excepción de validación de datos. 
    Indica que los datos no cumplen con los criterios esperados.
    """
    pass

class IOException(Exception):
    """
    Excepción de entrada/salida. 
    Indica que ocurrió un error durante una operación de E/S.
    """
    pass