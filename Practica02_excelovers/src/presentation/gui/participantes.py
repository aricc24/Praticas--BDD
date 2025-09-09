"""
Módulo de interfaz gráfica para la gestión de participantes.
Proporciona una interfaz CRUD para gestionar participantes con validación exhaustiva de datos.
"""


from .gui import BaseCRUD
import os, csv
from tkinter import messagebox
from datetime import datetime

DATA_DIR = os.path.join(os.path.dirname(__file__), "..", "..", "data")
PARTICIPANTS_FILE = os.path.join(DATA_DIR, "participants.csv")

FIELDS = [
    "numero_cuenta","nombre","apellido_pat","apellido_mat",
    "fecha_nac","sexo","telefonos","correos","facultad","carrera"
]

class ParticipanteGUI(BaseCRUD):
    """
    Interfaz gráfica para la gestión de participantes.
    Hereda de BaseCRUD para proporcionar funcionalidades básicas de CRUD.
    Implementa validación específica para datos de participantes.
    
    Attributes:
        root: Ventana principal de la aplicación Tkinter.
    """
    def __init__(self, root):
        """
        Inicializa la interfaz gráfica para participantes.
        
        Args:
            root: Ventana principal de la aplicación Tkinter.
        """
        super().__init__(root, "Participantes", PARTICIPANTS_FILE, FIELDS)

    def validate(self, row):
        """
        Valida los datos de un participante antes de guardarlos.
        Realiza validaciones exhaustivas para cada campo del formulario.
        
        Args:
            row (list): Lista con los valores de los campos a validar.
            
        Returns:
            bool: True si la validación es exitosa, False en caso contrario.
        """
        if not row[0].isdigit() or len(row[0]) != 9:
            messagebox.showerror("Error", "Número de cuenta debe ser numérico de 9 dígitos.")
            return False
        
        if not row[1].strip():
            messagebox.showerror("Error", "Nombre no puede estar vacío.")
            return False
        if any(char.isdigit() for char in row[1]):
            messagebox.showerror("Error", "Nombre no puede contener números.")
            return False
        
        if not row[2].strip():
            messagebox.showerror("Error", "Apellido paterno no puede estar vacío.")
            return False
        if any(char.isdigit() for char in row[2]):
            messagebox.showerror("Error", "Apellido paterno no puede contener números.")
            return False
        
        if row[3].strip() and any(char.isdigit() for char in row[3]):
            messagebox.showerror("Error", "Apellido materno no puede contener números.")
            return False
        
        if row[4]:
            try:
                datetime.strptime(row[4], "%d-%m-%Y")
            except ValueError:
                messagebox.showerror("Error", "Fecha no válida (DD-MM-YYYY).")
                return False
        
        if row[5].upper() not in ["M", "F", "O"]:
            messagebox.showerror("Error", "Sexo debe ser M, F u O.")
            return False
        
        if row[6]:
            telefonos = [tel.strip() for tel in row[6].split(',')]  
            telefonos = [tel for tel in telefonos if tel]  
            
            for i, telefono in enumerate(telefonos):
                if not telefono.isdigit():
                    messagebox.showerror("Error", 
                        f"El teléfono #{i+1} '{telefono}' debe contener solo números.\n"
                        f"Formato correcto: 1234567890,9876543210")
                    return False
                if len(telefono) != 10:
                    messagebox.showerror("Error", 
                        f"El teléfono #{i+1} '{telefono}' debe tener exactamente 10 dígitos.\n"
                        f"Tiene {len(telefono)} dígitos. Formato: 10 dígitos sin espacios ni guiones.")
                    return False
        
        if row[7]: 
            correos = [correo.strip() for correo in row[7].split(',')]  
            correos = [correo for correo in correos if correo]  
            
            for i, correo in enumerate(correos):
                if '@' not in correo:
                    messagebox.showerror("Error", 
                        f"El correo #{i+1} '{correo}' no es válido. Debe contener un @.\n"
                        f"Formato correcto: usuario@dominio.com\n"
                        f"Ejemplo: ari@unam.mx, xime@ciencias.unam.mx")
                    return False
        
        return True
