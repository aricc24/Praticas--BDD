def validate_integer(value: str, field_name: str) -> int:
    """
    Valida que el valor sea un entero.
    """
    try:
        return int(value)
    except ValueError:
        raise ValueError(f"{field_name} debe ser un número entero.")
    

def validate_string(value: str, field_name: str) -> str:
    """
    Valida que el valor sea una cadena no vacía.
    """
    if not value or not isinstance(value, str):
        raise ValueError(f"{field_name} debe ser una cadena no vacía.")
    return value.strip()