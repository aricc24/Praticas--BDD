def validate_integer(value: str, field_name: str) -> int:
    """
    Valida que el valor sea un entero.

    Args:
        value (str): El valor a validar.
        field_name (str): El nombre del campo para mensajes de error.

    Returns:
        int: El valor convertido a entero.

    Raises:
        ValueError: Si el valor no es un entero válido.
    """
    try:
        return int(value)
    except ValueError:
        raise ValueError(f"{field_name} debe ser un número entero.")
    

def validate_string(value: str, field_name: str) -> str:
    """
    Valida que el valor sea una cadena no vacía.

    Args:
        value (str): El valor a validar.
        field_name (str): El nombre del campo para mensajes de error.

    Returns:
        str: El valor validado.

    Raises:
        ValueError: Si el valor es una cadena vacía o no es una cadena.
    """
    if not value or not isinstance(value, str):
        raise ValueError(f"{field_name} debe ser una cadena no vacía.")
    return value.strip()