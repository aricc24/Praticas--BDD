"""
Módulo de interfaz gráfica para la gestión de cuentas de entrenadores.
Proporciona una interfaz CRUD para gestionar cuentas con validación de datos.
"""

from .gui import BaseCRUD
import os
from tkinter import messagebox

DATA_DIR = os.path.join(os.path.dirname(__file__), "..", "..", "data")
CUENTAS_FILE = os.path.join(DATA_DIR, "cuentas.csv")

FIELDS = ["codigo_entrenador","nombre_usuario","nivel_entrenador","equipo"]

class CuentaGUI(BaseCRUD):
    """
    Interfaz gráfica para la gestión de cuentas de entrenadores.
    Hereda de BaseCRUD para proporcionar funcionalidades básicas de CRUD.
    
    Attributes:
        root: Ventana principal de la aplicación Tkinter.
    """
    def __init__(self, root):
        """
        Inicializa la interfaz gráfica para cuentas.
        
        Args:
            root: Ventana principal de la aplicación Tkinter.
        """
        super().__init__(root, "Cuentas", CUENTAS_FILE, FIELDS)

    def validate(self, row):
        """
        Valida los datos de una cuenta antes de guardarlos.
        
        Args:
            row (list): Lista con los valores de los campos a validar.
            
        Returns:
            bool: True si la validación es exitosa, False en caso contrario.
        """
        if not row[0].isdigit():
            messagebox.showerror("Error", "Código de entrenador debe ser numérico.")
            return False
        if not row[2].isdigit():
            messagebox.showerror("Error", "Nivel de entrenador debe ser numérico.")
            return False
        
        equipo = row[3].strip().upper()
        equipo = equipo.replace('Á', 'A').replace('É', 'E').replace('Í', 'I')
        equipo = equipo.replace('Ó', 'O').replace('Ú', 'U')
        
        equipos_validos = ["SABIDURIA", "INSTINTO", "VALOR"]
        
        if equipo not in equipos_validos:
            messagebox.showerror("Error", 
                "Equipo debe ser: Sabiduría, Instinto o Valor.\n"
                f"Recibido: {row[3]}\n"
                "Ejemplos válidos: Sabiduria, Instinto, VALOR, sabiduría")
            return False
        
        return True
