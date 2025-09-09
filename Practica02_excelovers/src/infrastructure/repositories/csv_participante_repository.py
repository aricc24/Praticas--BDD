"""
Módulo de repositorio CSV para la entidad Participante.

Este módulo implementa la interfaz IParticipanteRepository utilizando archivos CSV.
"""
from domain.entities.participante import Participante
from domain.repositories.i_participante_repository import IParticipanteRepository
from infrastructure.file_handlers import CSVFileHandler

class ParticipanteRepositoryCSV(IParticipanteRepository):
    """
    Implementación del repositorio de Participantes usando archivos CSV.
    
    Esta clase proporciona los métodos necesarios para persistir y
    recuperar datos de participantes desde/hacia archivos CSV, como guardar, buscar, actualizar y 
    eliminar participantes.
    Attributes:
        file_path (str): Ruta al archivo CSV utilizado
        file_handler (CSVFileHandler): Manejador de archivos CSV auxiliar
    """
    def __init__(self, file_path: str):
        """
        Inicializa el repositorio con la ruta al archivo CSV.
        
        Args:
            file_path (str): Ruta completa al archivo CSV donde se almacenarán
                            los datos de los participantes
        """
        self.file_path = file_path
        self.file_handler = CSVFileHandler(file_path, [
            'numero_cuenta', 'nombre', 'apellido_pat', 'apellido_mat', 'fecha_nac', 'sexo',
            'telefonos', 'correos', 'facultad', 'carrera'
        ])

    def save(self, p: Participante): 
        """
        Guarda un nuevo participante en el archivo CSV.
        
        Args:
            p (Participante): participante a ser guardado.
            
        Raises:
            Exception: Si ocurre algún error durante la operación de guardado
        """
        try: 
            data = p.to_dict()
            self.file_handler.append_data(data)
        except Exception as e:
            print(f"Error al guardar el participante: {e}")
            raise e

 
    def get_by_numero_cuenta(self, numero_cuenta: str) -> Participante | None: 
        """
        Busca un participante por su número de cuenta.
        
        Args:
            numero_cuenta (str): Número de cuenta único del participante a buscar
            
        Returns:
            Participante | None: El participante encontrado o None si no existe
            
        Raises:
            Exception: Si ocurre algún error durante la operación de búsqueda
        """
        try:
            df = self.file_handler.lookup('numero_cuenta', numero_cuenta)
         
            if not df.empty:
                return Participante.from_dict(df.iloc[0].to_dict())
        except Exception as e:
            print(f"Error al obtener el participante: {e}")
            raise e

    def update(self, p: Participante): 
        """
        Actualiza la información de un participante existente.
        
        Args:
            p (Participante): Participante con los datos actualizados
            
        Raises:
            Exception: Si ocurre algún error durante la operación de actualización
        """
        try:
            df = self.file_handler.read_data()
            index = df.index[df['numero_cuenta'] == int(p.numero_cuenta)].tolist()
            if index:
                df.loc[index[0]] = p.to_dict()
                self.file_handler.write_data(df)
        except Exception as e:
            print(f"Error al actualizar el participante: {e}")
            raise e

    
    def delete(self, numero_cuenta: int): 
        """
        Elimina un participante del repositorio por su número de cuenta.
        
        Args:
            numero_cuenta (int): Número de cuenta único del participante a eliminar
            
        Raises:
            Exception: Si ocurre algún error durante la operación de eliminación
        """
        try:
            df = self.file_handler.read_data()
            df = df[df['numero_cuenta'] != numero_cuenta]
            self.file_handler.write_data(df)
        except Exception as e:
            print(f"Error al eliminar el participante: {e}")
            raise e

            

