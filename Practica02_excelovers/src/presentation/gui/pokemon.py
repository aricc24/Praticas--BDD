"""
Módulo de interfaz gráfica para la gestión de Pokémon.
Proporciona una interfaz CRUD para gestionar Pokémon con validación de datos específica.
"""

from .gui import BaseCRUD
import os
from tkinter import messagebox

DATA_DIR = os.path.join(os.path.dirname(__file__), "..", "..", "data")
POKEMONS_FILE = os.path.join(DATA_DIR, "pokemons.csv")
CSV_FIELDS = ["pokemon_id", "nombre", "especie", "tipo", "cp", "peso", "sexo", "shiny"]
FORM_FIELDS = ["nombre", "especie", "tipo", "cp", "peso", "sexo", "shiny"]

class PokemonGUI(BaseCRUD):
    """
    Interfaz gráfica para la gestión de Pokémon.
    Hereda de BaseCRUD para proporcionar funcionalidades básicas de CRUD.
    Implementa validación específica para datos de Pokémon.
    
    Attributes:
        root: Ventana principal de la aplicación Tkinter.
    """
    def __init__(self, root):
        """
        Inicializa la interfaz gráfica para Pokémon.
        
        Args:
            root: Ventana principal de la aplicación Tkinter.
        """
        super().__init__(root, "Pokémon", POKEMONS_FILE, CSV_FIELDS, form_fields=FORM_FIELDS)

    def validate(self, row):
        """
        Valida los datos de un Pokémon antes de guardarlos.
        Realiza validaciones específicas para cada campo del formulario.
        
        Args:
            row (list): Lista con los valores de los campos a validar.
            
        Returns:
            bool: True si la validación es exitosa, False en caso contrario.
        """
        if not row[0].strip():
            messagebox.showerror("Error", "El nombre del Pokémon no puede estar vacío.")
            return False
            
        if not row[3].isdigit():
            messagebox.showerror("Error", "El CP debe ser numérico.")
            return False
            
        try:
            float(row[4])
        except ValueError:
            messagebox.showerror("Error", "El peso debe ser numérico.")
            return False
            
        if row[5].upper() not in ["M", "F", "O"]:
            messagebox.showerror("Error", "Sexo debe ser M, F u O.")
            return False

        if row[6].lower() not in ["true", "false"]:
            messagebox.showerror("Error", "Shiny debe ser True o False.")
            return False
            
        return True
