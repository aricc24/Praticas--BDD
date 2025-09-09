from .gui import BaseCRUD
import os
from tkinter import messagebox

DATA_DIR = os.path.join(os.path.dirname(__file__), "..", "..", "data")
POKEMONS_FILE = os.path.join(DATA_DIR, "pokemons.csv")

FIELDS = ["nombre","especie","tipo","cp","peso","sexo","shiny"]

class PokemonGUI(BaseCRUD):
    def __init__(self, root):
        super().__init__(root, "Pokémon", POKEMONS_FILE, FIELDS)

    def validate(self, row):
        if not row[0].isdigit():
            messagebox.showerror("Error", "El ID del Pokémon debe ser numérico.")
            return False
        if not row[4].isdigit():
            messagebox.showerror("Error", "El CP debe ser numérico.")
            return False
        try:
            float(row[5])
        except ValueError:
            messagebox.showerror("Error", "El peso debe ser numérico.")
            return False
        if row[6].upper() not in ["M","F","O"]:
            messagebox.showerror("Error", "Sexo debe ser M, F u O.")
            return False
        if row[7].lower() not in ["true","false"]:
            messagebox.showerror("Error", "Shiny debe ser True o False.")
            return False
        return True
