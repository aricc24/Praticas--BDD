from domain.entities.cuenta import Cuenta
from domain.entities.enums.equipo_cuenta import EquipoCuenta
from domain.repositories.i_cuenta_repository import ICuentaRepository
from utils.exceptions.exceptions import EntityNotFoundException, ValidationException

class CuentaService:
    """
    Servicio para las cuentas.
    Permite crear, actualizar, eliminar y consultar cuentas.
    """

    def __init__(self, repository: ICuentaRepository):
        """
        Inicializa el servicio con un repositorio de cuentas.

        Args:
            repository (ICuentaRepository): Repositorio de cuentas.
        """
        self.repository = repository

    def add_cuenta(self, codigo_entrenador: int, nombre_usuario: str, nivel_entrenador: int, equipo: EquipoCuenta) -> Cuenta:
        """
        Crea y guarda una nueva cuenta en el repositorio.

        Args:
            codigo_entrenador (int): Código único del entrenador.
            nombre_usuario (str): Nombre de usuario de la cuenta.
            nivel_entrenador (int): Nivel del entrenador.
            equipo (EquipoCuenta): Equipo al que pertenece el entrenador.

        Returns:
            Cuenta: La cuenta creada y guardada.

        Raises:
            ValidationException: Si la cuenta ya existe.
        """
        existing = self.repository.find_by_codigo_entrenador(codigo_entrenador)
        if existing is not None:
            raise ValidationException(f"La cuenta con código {codigo_entrenador} ya existe.")
        cuenta = Cuenta(
            _codigo_entrenador=codigo_entrenador,
            _nombre_usuario=nombre_usuario,
            _nivel_entrenador=nivel_entrenador,
            _equipo=equipo
        )
        self.repository.save(cuenta)
        return cuenta

    def get_cuenta(self, codigo_entrenador: int) -> Cuenta:
        """
        Recupera una cuenta por su código de entrenador.

        Args:
            codigo_entrenador (int): Código único del entrenador.

        Returns:
            Cuenta: La cuenta encontrada.

        Raises:
            EntityNotFoundException: Si la cuenta no existe.
        """
        cuenta = self.repository.find_by_codigo_entrenador(codigo_entrenador)
        if cuenta is None:
            raise EntityNotFoundException(f"No se encontró la cuenta con código {codigo_entrenador}.")
        return cuenta

    def get_all_cuentas(self) -> list[Cuenta]:
        """
        Recupera todas las cuentas del repositorio.

        Returns:
            list[Cuenta]: Lista de todas las cuentas.
        """
        return self.repository.all()

    def update_cuenta(self, codigo_entrenador: int, nombre_usuario: str, nivel_entrenador: int, equipo: EquipoCuenta) -> Cuenta:
        """
        Actualiza los datos de una cuenta existente.

        Args:
            codigo_entrenador (int): Código único del entrenador.
            nombre_usuario (str): Nuevo nombre de usuario.
            nivel_entrenador (int): Nuevo nivel del entrenador.
            equipo (EquipoCuenta): Nuevo equipo del entrenador.

        Returns:
            Cuenta: La cuenta actualizada.

        Raises:
            EntityNotFoundException: Si la cuenta no existe.
        """
        c = self.repository.find_by_codigo_entrenador(codigo_entrenador)
        if c is None:
            raise EntityNotFoundException(f"No se puede actualizar, la cuenta con código {codigo_entrenador} no existe.")
        c.nombre_usuario = nombre_usuario
        c.nivel_entrenador = nivel_entrenador
        c.equipo = equipo
        self.repository.update(c)
        return c

    def delete_cuenta(self, codigo_entrenador: int) -> None:
        """
        Elimina una cuenta por su código de entrenador.

        Args:
            codigo_entrenador (int): Código del entrenador a eliminar.

        Raises:
            EntityNotFoundException: Si la cuenta no existe.
        """
        c = self.repository.find_by_codigo_entrenador(codigo_entrenador)
        if c is None:
            raise EntityNotFoundException(f"No se puede eliminar, la cuenta con código {codigo_entrenador} no existe.")
        self.repository.delete(codigo_entrenador)
