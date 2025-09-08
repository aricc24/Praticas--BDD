"""
Implementación CSV del Repositorio de Cuentas.
"""

import csv
from typing import Optional
from domain.entities.cuenta import Cuenta
from domain.repositories.i_cuenta_repository import CuentaRepository

class CsvCuentaRepository(CuentaRepository):
     
    def save(self, c: Cuenta): pass

    
    def find_by_nombre_usuario(self, codigo_entrenador: int) -> Cuenta | None: pass

    
    def update(self, c: Cuenta): pass

    
    def delete(self, codigo_entrenador: int): pass


    def all(self) -> list[Cuenta]: pass