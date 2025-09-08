from domain.entities.cuenta import Cuenta
from domain.repositories.i_cuenta_repository import ICuentaRepository
from infrastructure.file_handlers import CSVFileHandler

class CuentaRepositoryCSV(ICuentaRepository):
    """
    Implementación del repositorio de Cuentas utilizando archivos CSV.
    Proporciona métodos para guardar, buscar, actualizar y eliminar cuentas
    en un archivo CSV.
    """

    def __init__(self, file_path: str):
        self.file_path = file_path
        self.file_handler = CSVFileHandler(file_path, ['codigo_entrenador', 'nombre_usuario', 'nivel_entrenador', 'equipo'])

    def save(self, c: Cuenta) -> None:
        """
        Guarda una nueva cuenta en el repositorio.

        Args:
            c (Cuenta): La cuenta a guardar.

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
        """
        try:
            df = self.file_handler.read_data()
            if df is None or df.empty:
                return []
            cuentas = [Cuenta.from_dict(row) for _, row in df.iterrows()]
            return cuentas
        except Exception as e:
            raise Exception(f"Error al recuperar las cuentas: {e}")