import pandas as pd
import os

class CSVFileHandler:
    
    def __init__(self, file_path: str, columns: list):
        self.file_path = file_path
        self.columns = columns
        self._initialize_file()

    def _initialize_file(self):
        if not os.path.exists(self.file_path):
            df = pd.DataFrame(columns=self.columns)
            df.to_csv(self.file_path, index=False)

    def read_data(self) -> pd.DataFrame:
        try:
            return pd.read_csv(self.file_path)
        except Exception as e:
            print(f"Error al leer el archivo CSV: {e}")
            raise e # crear excepcioon
        
    def write_data(self, df: pd.DataFrame):
        try:
            df.to_csv(self.file_path, index=False)
        except Exception as e:
            print(f"Error al escribir en el archivo CSV: {e}")
            raise e # crear excepcioon
    
    def append_data(self, data: dict):
        df = pd.DataFrame([data])
        try:
            df = self.read_data()
            new_df = pd.DataFrame([data])
            df = pd.concat([df, new_df], ignore_index=True)
            self.write_data(df)
        except Exception as e:
            print(f"Error al agregar datos al archivo CSV: {e}")
            raise e # crear excepcioon
