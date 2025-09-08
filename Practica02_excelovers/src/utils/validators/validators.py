from domain.entities.enums.equipo_cuenta import EquipoCuenta
import re

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
    
def validate_float(value: str, field_name: str) -> float:
    """
    Valida que el valor sea un número de punto flotante.

    Args:
        value (str): El valor a validar.
        field_name (str): El nombre del campo para mensajes de error.

    Returns:
        float: El valor convertido a float.

    Raises:
        ValueError: Si el valor no es un número de punto flotante válido.
    """
    try:
        return float(value)
    except ValueError:
        raise ValueError(f"{field_name} debe ser un número decimal.")
    

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

def validate_equipo(value: str, field_name: str) -> EquipoCuenta:
    """
    Valida que el valor corresponda a un equipo válido de EquipoCuenta.

    Args:
        value (str): El valor a validar.

    Returns:
        EquipoCuenta: El equipo correspondiente a la entrada.

    Raises:
        ValueError: Si el valor no corresponde a ningún equipo válido.
    """
    try:
        return EquipoCuenta[value.strip().upper()]
    except KeyError:
        valid_teams = ', '.join([team.name for team in EquipoCuenta])
        raise ValueError(f"{field_name} debe ser uno de los siguientes: {valid_teams}.")
def validate_date(value: str, field_name: str) -> str:
    """
    Valida que el valor sea una fecha en formato DD-MM-YYYY.
    """
    pattern = r'^\d{2}-\d{2}-\d{4}$'
    if not re.match(pattern, value):
        raise ValueError(f"{field_name} debe tener el formato DD-MM-YYYY.")
    dia, mes, anio = map(int, value.split('-'))
    if not (1 <= dia <= 31 and 1 <= mes <= 12 and anio > 1900):
        raise ValueError(f"{field_name} no es una fecha válida.")
    return value

def validate_sexo(value: str, field_name: str) -> str:
    """
    Valida que el valor sea 'M', 'F' o 'O'.
    """
    value = value.upper()
    if value not in ['M', 'F', 'O']:
        raise ValueError(f"{field_name} debe ser 'M', 'F' o 'O'.")
    return value

def validate_int_list(value: str, field_name: str) -> list:
    """
    Valida que el valor sea una lista de enteros separados por comas.
    """
    
    if not value:
        raise ValueError(f"Debes ingresar algún valor para {field_name} ")
    try:
        return [int(item.strip()) for item in value.split(',') if item.strip()]
    except ValueError:
        raise ValueError(f"{field_name} debe ser una lista de números enteros separados por comas.")
    
def validate_list(value: str, field_name: str) -> list:
    """
    Valida que el valor sea una lista de cadenas separadas por comas.
    """
    if not value:
        raise ValueError(f"Debes ingresar algún valor para {field_name} ")
    try:
        return [item.strip() for item in value.split(',') if item.strip()]
    except ValueError:
        raise ValueError(f"{field_name} debe ser una lista de cadenas separadas por comas.")

def validate_correos(value: str, field_name: str) -> list:

    """
    Valida que el valor sea una lista de correos electrónicos separados por comas.
    """
    if not value:
        raise ValueError(f"Debes ingresar algún valor para {field_name} ")
    correos = [item.strip() for item in value.split(',') if item.strip()]
    for correo in correos:
        if not re.match(r"^[\w\.-]+@[\w\.-]+\.\w+$", correo):
            raise ValueError(f"{field_name} debe ser una lista de correos electrónicos válidos.")
    return correos

def validate_input(value: str, validator, field_name: str):
    """
    Valida la entrada utilizando la función de validación proporcionada.

    Args:
        value (str): El valor a validar.
        validator (function): La función de validación a utilizar.
        field_name (str): El nombre del campo para mensajes de error.

    Returns:
        The validated value.

    Raises:
        ValueError: Si la validación falla.
    """
    while True:
        try:
            return validator(value, field_name)
        except ValueError as ve:
            print(f"Error: {ve}")
            value = input(f"Ingrese nuevamente el valor para {field_name}: ")