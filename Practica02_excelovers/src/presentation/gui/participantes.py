from .gui import BaseCRUD
import os, csv
from tkinter import messagebox
from datetime import datetime

DATA_DIR = os.path.join(os.path.dirname(__file__), "..", "data")
PARTICIPANTS_FILE = os.path.join(DATA_DIR, "participants.csv")

FIELDS = [
    "numero_cuenta","nombre","apellido_pat","apellido_mat",
    "fecha_nac","sexo","telefonos","correos","facultad","carrera"
]

class ParticipanteGUI(BaseCRUD):
    def __init__(self, root):
        super().__init__(root, "Participantes - CRUD", PARTICIPANTS_FILE, FIELDS)

    def validate(self, row):
        if not row[0].isdigit():
            messagebox.showerror("Error", "Número de cuenta debe ser numérico.")
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
        return True
