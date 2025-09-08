
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

 
    def get_by_numero_cuenta(self, participante_id: str) -> Participante | None: 
        try:
            df = self.file_handler.lookup('numero_cuenta', participante_id)
            if not df.empty:
                return Participante.from_dict(df.iloc[0].to_dict())
        except Exception as e:
            print(f"Error al obtener el participante: {e}")
            raise e

    def update(self, p: Participante): 
        try:
            df = self.file_handler.read_data()
            index = df.index[df['numero_cuenta'] == p.numero_cuenta].tolist()
            if index:
                df.loc[index[0]] = p.to_dict()
                self.file_handler.write_data(df)
        except Exception as e:
            print(f"Error al actualizar el participante: {e}")
            raise e

    
    def delete(self, participante_id: str): 
        try:
            df = self.file_handler.read_data()
            df = df[df['numero_cuenta'] != participante_id]
            self.file_handler.write_data(df)
        except Exception as e:
            print(f"Error al eliminar el participante: {e}")
            raise e

    def all(self) -> list[Participante]:
        try:
            df = self.file_handler.read_data()
            return [Participante.from_dict(row.to_dict()) for _, row in df.iterrows()]
        except Exception as e:
            print(f"Error al obtener todos los participantes: {e}")
            raise e