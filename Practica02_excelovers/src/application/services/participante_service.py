from domain.repositories.i_participante_repository import IParticipanteRepository

from domain.entities.participante import Participante

class ParticipanteService:
    def __init__(self, repository: IParticipanteRepository):
        self.repository = repository

    def add_participante(self, nombre: str, apellido_pat: str, apellido_mat: str, fecha_nac: str,
                         edad: int, sexo: str, telefonos: list[int], correos: list[str],
                         numero_cuenta: int, facultad: str, carrera: str) -> None:
        # revisasi ya estaba
        participante = Participante(
            nombre=nombre,
            apellido_pat=apellido_pat,
            apellido_mat=apellido_mat,
            fecha_nac=fecha_nac,
            edad=edad,
            sexo=sexo,
            telefonos=telefonos,
            correos=correos,
            numero_cuenta=numero_cuenta,
            facultad=facultad,
            carrera=carrera
        )
        self.repository.save(participante)
        return participante

    def get_by_numero_cuenta(self, numero_cuenta: int) -> Participante:
        return self.repository.get_by_numero_cuenta(numero_cuenta)

    def update_participante(self, numero_cuenta: int, **updates) -> bool:
       
        participante = self.repository.get_by_numero_cuenta(numero_cuenta)
       
        if not participante:
            return False
        for key, value in updates.items():
            if hasattr(participante, key):
                setattr(participante, key, value)
        self.repository.update(participante)
        return True

    def delete_participante(self, numero_cuenta: int) -> bool:
        participante = self.repository.get_by_numero_cuenta(numero_cuenta)
        if not participante:
            return False
        self.repository.delete(numero_cuenta)
        return True