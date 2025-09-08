
from domain.entities.participante import Participante
from domain.repositories.i_participante_repository import IParticipanteRepository
from infrastructure.file_handlers import CSVFileHandler

class ParticipanteRepositoryCSV(IParticipanteRepository):
    def __init__(self, file_path: str):
        self.file_path = file_path
        self.file_handler = CSVFileHandler(file_path, [
            'nombre', 'apellido_pat', 'apellido_mat', 'fecha_nac', 'edad', 'sexo',
            'telefonos', 'correos', 'numero_cuenta', 'facultad', 'carrera'
        ])

    def save(self, p: Participante): 
        try: 
            data = p.to_dict()
            self.file_handler.append_data(data)
        except Exception as e:
            print(f"Error al guardar el participante: {e}")
            raise e

 
    def find_by_numero_cuenta(self, participante_id: str) -> Participante | None: pass

    
    def update(self, p: Participante): pass

    
    def delete(self, participante_id: str): pass

   
    def all(self) -> list[Participante]: pass