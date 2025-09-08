
import pandas as pd
import os
from utils.exceptions.exceptions import IOException

class CSVFileHandler:
    """
    Clase para manejar la lectura, escritura y actualización de archivos CSV.

    Attributes:
        file_path (str): Ruta del archivo CSV.
        columns (list): Lista de nombres de columnas del CSV.
    """

    def __init__(self, file_path: str, columns: list):
        """
        Inicializa el manejador de CSV y asegura que el archivo exista.

        Args:
            file_path (str): Ruta del archivo CSV.
            columns (list): Lista de columnas del archivo CSV.
        """
        self.file_path = file_path
        self.columns = columns
        self._initialize_file()

    def _initialize_file(self):
        """
        Crea el archivo CSV si no existe, con las columnas especificadas.
        """
        if not os.path.exists(self.file_path):
            df = pd.DataFrame(columns=self.columns)
            df.to_csv(self.file_path, index=False)

    def read_data(self) -> pd.DataFrame:
        """
        Lee los datos del archivo CSV.

        Returns:
            pd.DataFrame: DataFrame con los datos del CSV.

        Raises:
            IOException: Si ocurre un error al leer el archivo CSV.
        """
        try:
            return pd.read_csv(self.file_path,  dtype={
                "numero_cuenta": int,  
                "telefonos": str,
                "correos": str,
                "nombre": str,
                "apellido_pat": str,
                "apellido_mat": str,
                "sexo": str,
                "facultad": str,
                "carrera": str,
                "fecha_nac":str
            })
        except Exception as e:
            raise IOException(f"Error al leer el archivo CSV: {e}")

    def write_data(self, df: pd.DataFrame):
        """
        Sobrescribe el archivo CSV con los datos del DataFrame proporcionado.

        Args:
            df (pd.DataFrame): DataFrame con los datos a guardar.

        Raises:
            IOException: Si ocurre un error al escribir en el archivo CSV.
        """
        try:
            df.to_csv(self.file_path, index=False)
        except Exception as e:
            raise IOException(f"Error al escribir en el archivo CSV: {e}")

    def append_data(self, data: dict):
        """
        Agrega un nuevo registro al archivo CSV.

        Args:
            data (dict): Diccionario con los datos a agregar.

        Raises:
            IOException: Si ocurre un error al agregar datos al archivo CSV.
        """
        try:
            df = self.read_data()
            new_df = pd.DataFrame([data])
            df = pd.concat([df, new_df], ignore_index=True)
            self.write_data(df)
        except Exception as e:
            raise IOException(f"Error al agregar datos al archivo CSV: {e}")

    def lookup(self, key: str, value) -> pd.DataFrame:
        """
        Busca registros en el CSV donde la columna `key` tenga el valor `value`.

        Args:
            key (str): Nombre de la columna para buscar.
            value: Valor a buscar en la columna.

        Returns:
            pd.DataFrame: DataFrame con los registros que coinciden.
        """
        df = self.read_data()
        return df[df[key] == value]
