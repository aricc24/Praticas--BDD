"""
Módulo de repositorio CSV para la entidad Cuenta.

Este módulo implementa la interfaz ICuentaRepository utilizando archivos CSV.
"""
from domain.entities.cuenta import Cuenta
from domain.repositories.i_cuenta_repository import ICuentaRepository
from infrastructure.file_handlers import CSVFileHandler

class CuentaRepositoryCSV(ICuentaRepository):
    """
    Implementación del repositorio de Cuentas utilizando archivos CSV.
    Proporciona métodos para guardar, buscar, actualizar y eliminar cuentas
    en un archivo CSV.
    Attributes:
        file_path (str): Ruta al archivo CSV utilizado
        file_handler (CSVFileHandler): Manejador de archivos CSV auxiliar
    """

    def __init__(self, file_path: str):
        """
        Inicializa el repositorio con la ruta al archivo CSV.

        Args:
            file_path (str): Ruta al archivo CSV
        """
        self.file_path = file_path
        self.file_handler = CSVFileHandler(file_path, ['codigo_entrenador', 'nombre_usuario', 'nivel_entrenador', 'equipo'])

    def save(self, c: Cuenta) -> None:
        """
        Guarda una nueva cuenta en el repositorio.

        Args:
            c (Cuenta): La cuenta a guardar.

        Raises:
            Exception: Si ocurre algún error durante la operación de guardado

        Returns:
            None
        """
        try:
            data = c.to_dict()
            self.file_handler.append_data(data)
        except Exception as e:
            raise Exception(f"Error al guardar la cuenta: {e}")

    def find_by_codigo_entrenador(self, codigo_entrenador: int) -> Cuenta | None:
        """
        Busca una cuenta en el repositorio a partir de su código de entrenador.

        Args:
            codigo_entrenador (int): El código único del entrenador asociado a la cuenta.

        Returns:
            Cuenta | None: La cuenta encontrada o None si no existe.
        
        Raises:
            Exception: Si ocurre algún error durante la operación de búsqueda
        """
        try:
            df = self.file_handler.read_data()
            if df is None or df.empty:
                return None
            data = df[df['codigo_entrenador'] == codigo_entrenador]
            if data.empty:
                return None
            row = data.iloc[0].to_dict()
            return Cuenta.from_dict(row)
        except Exception as e:
            raise Exception(f"Error al buscar la cuenta: {e}")

    def update(self, c: Cuenta) -> None:
        """
        Actualiza la información de una cuenta existente.

        Args:
            c (Cuenta): La cuenta con la información actualizada.

        Raises:
            Exception: Si ocurre algún error durante la operación de actualización
    
        Returns:
            None
        """
        try:
            df = self.file_handler.read_data()
            idx = df[df['codigo_entrenador'] == c.codigo_entrenador].index
            df.loc[idx[0]] = c.to_dict()
            self.file_handler.write_data(df)
        except Exception as e:
            raise Exception(f"Error al actualizar la cuenta: {e}")

    def delete(self, codigo_entrenador: int) -> None:
        """
        Elimina una cuenta del repositorio por su código de entrenador.

        Args:
            codigo_entrenador (int): El código del entrenador asociado a la cuenta a eliminar.
        
        Raises:
            Exception: Si ocurre algún error durante la operación de eliminación

        Returns:
            None
        """
        try:
            df = self.file_handler.read_data()
            df = df[df['codigo_entrenador'] != codigo_entrenador]
            self.file_handler.write_data(df)
        except Exception as e:
            raise Exception(f"Error al eliminar la cuenta: {e}")

    def all(self) -> list[Cuenta]:
        """
        Recupera todas las cuentas almacenadas en el repositorio.

        Returns:
            list[Cuenta]: Una lista de todas las cuentas.
         Raises:
            Exception: Si ocurre algún error durante la operación de lectura
        """
        try:
            df = self.file_handler.read_data()
            if df is None or df.empty:
                return []
            cuentas = [Cuenta.from_dict(row) for _, row in df.iterrows()]
            return cuentas
        except Exception as e:
            raise Exception(f"Error al recuperar las cuentas: {e}")