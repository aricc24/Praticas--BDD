"""
Módulo de interfaz gráfica base para operaciones CRUD.
Proporciona una base reutilizable para interfaces de creación, lectura, actualización y eliminación de registros.
"""

import tkinter as tk
from tkinter import ttk, messagebox
import csv
import os

class BaseCRUD:
    """
    Clase base para interfaces CRUD que manejan operaciones sobre archivos CSV.
    
    Attributes:
        filename (str): Ruta al archivo CSV donde se almacenan los datos.
        fields (list): Lista de campos/columnas del archivo CSV.
        form_fields (list): Lista de campos a mostrar en el formulario (puede diferir de fields).
        window (Toplevel): Ventana principal de la interfaz CRUD.
        tree (Treeview): Widget de tabla para mostrar los registros.
    """

    def __init__(self, root, title, filename, fields, form_fields=None):
        """
        Inicializa la interfaz CRUD base.
        
        Args:
            root: Ventana raíz de la aplicación Tkinter.
            title (str): Título de la ventana.
            filename (str): Ruta al archivo CSV para almacenar datos.
            fields (list): Lista de campos/columnas del archivo CSV.
            form_fields (list, optional): Campos a mostrar en formularios. Si es None, usa fields.
        """
        self.filename = filename
        self.fields = fields
        self.form_fields = form_fields if form_fields is not None else self.fields

        self.window = tk.Toplevel(root)
        self.window.title(title)
        self.window.geometry("1000x500")

        self.tree = ttk.Treeview(self.window, columns=fields, show="headings")
        for f in fields:
            self.tree.heading(f, text=f.replace("_", " ").capitalize())
            self.tree.column(f, width=120)
        self.tree.pack(fill="both", expand=True)

        frame = tk.Frame(self.window)
        frame.pack(pady=10)
        tk.Button(frame, text="Agregar", command=self.add).grid(row=0, column=0, padx=5)
        tk.Button(frame, text="Editar", command=self.edit).grid(row=0, column=1, padx=5)
        tk.Button(frame, text="Eliminar", command=self.delete).grid(row=0, column=2, padx=5)
        tk.Button(frame, text="Consultar", command=self.consultar).grid(row=0, column=3, padx=5)
        tk.Button(frame, text="Actualizar", command=self.load_data).grid(row=0, column=4, padx=5)
        self.load_data()

    def load_data(self):
        """Carga los datos desde el archivo CSV y los muestra en la tabla."""
        for row in self.tree.get_children():
            self.tree.delete(row)
        try:
            with open(self.filename, newline="", encoding="utf-8") as f:
                reader = csv.reader(f)
                header = next(reader, None)
                if header:
                    for row in reader:
                        self.tree.insert("", "end", values=row)
        except FileNotFoundError:
            data_dir = os.path.dirname(self.filename)
            os.makedirs(data_dir, exist_ok=True)
            with open(self.filename, "w", newline="", encoding="utf-8") as f:
                writer = csv.writer(f)
                writer.writerow(self.fields)

    def _get_next_id(self):
        """
        Obtiene el siguiente ID disponible para un nuevo registro.
        
        Returns:
            int: Siguiente ID disponible.
        """
        try:
            with open(self.filename, 'r', newline='', encoding='utf-8') as f:
                reader = csv.reader(f)
                header = next(reader, None)
                last_row = None
                for last_row in reader:
                    pass
                if last_row:
                    return int(last_row[0]) + 1
                return 1
        except (FileNotFoundError, StopIteration, ValueError):
            return 1

    def add(self):
        """Abre el formulario para agregar un nuevo registro."""
        self._open_form("Agregar")

    def edit(self):
        """Abre el formulario para editar el registro seleccionado."""
        item = self.tree.selection()
        if not item:
            messagebox.showwarning("Advertencia", "Selecciona un registro para editar")
            return
        values = self.tree.item(item[0], "values")
        self._open_form("Editar", values)

    def delete(self):
        """Elimina el registro seleccionado después de confirmación."""
        item = self.tree.selection()
        if not item:
            messagebox.showwarning("Advertencia", "Selecciona un registro para eliminar")
            return
        if not messagebox.askyesno("Confirmar", "¿Estás seguro de que deseas eliminar este registro?"):
            return
        values = self.tree.item(item[0], "values")
        rows = []
        with open(self.filename, newline="", encoding="utf-8") as f:
            reader = list(csv.reader(f))
        header, data = reader[0], reader[1:]
        rows = [header] + [r for r in data if r != list(values)]
        with open(self.filename, "w", newline="", encoding="utf-8") as f:
            writer = csv.writer(f)
            writer.writerows(rows)
        self.load_data()

    def consultar(self):
        """Abre un diálogo para consultar un registro por su ID/llave principal."""
        id_field = self.fields[0]
        id_field_label = self._get_field_labels().get(id_field, id_field.replace("_", " ").capitalize())
        
        dialog = tk.Toplevel(self.window)
        dialog.title(f"Consultar por {id_field_label}")
        dialog.geometry("400x200")
        
        tk.Label(dialog, text=f"Ingrese el {id_field_label.lower()}:").pack(pady=10)
        
        id_entry = tk.Entry(dialog, width=30)
        id_entry.pack(pady=5)
        
        def buscar_por_id():
            id_value = id_entry.get().strip()
            if not id_value:
                messagebox.showwarning("Advertencia", f"Por favor ingrese un {id_field_label.lower()}")
                return
            
            registro = self._buscar_por_id(id_value)
            if registro:
                self._open_consult_form(registro)
                dialog.destroy()
            else:
                messagebox.showerror("Error", f"No se encontró ningún registro con {id_field_label.lower()} {id_value}")
        
        tk.Button(dialog, text="Buscar", command=buscar_por_id).pack(pady=10)
        tk.Button(dialog, text="Cancelar", command=dialog.destroy).pack(pady=10)

    def _buscar_por_id(self, id_value):
        """
        Busca un registro por su ID/llave principal.
        
        Args:
            id_value (str): Valor del ID a buscar.
            
        Returns:
            list: Valores del registro encontrado, o None si no se encuentra.
        """
        try:
            with open(self.filename, newline="", encoding="utf-8") as f:
                reader = csv.reader(f)
                header = next(reader, None)
                if header:
                    for row in reader:
                        if row and row[0] == id_value:
                            return row
            return None
        except FileNotFoundError:
            return None

    def _open_consult_form(self, values):
        """
        Abre un formulario de solo lectura para consultar un registro.
        
        Args:
            values (list): Valores del registro a consultar.
        """
        form = tk.Toplevel(self.window)
        form.title("Consultar Registro")
        form.geometry("600x500")
        
        main_frame = tk.Frame(form)
        main_frame.pack(fill="both", expand=True, padx=20, pady=20)
        
        canvas = tk.Canvas(main_frame)
        scrollbar = ttk.Scrollbar(main_frame, orient="vertical", command=canvas.yview)
        scrollable_frame = tk.Frame(canvas)
        
        scrollable_frame.bind(
            "<Configure>",
            lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
        )
        
        canvas.create_window((0, 0), window=scrollable_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)
        
        for i, field in enumerate(self.fields):
            label_text = self._get_field_labels().get(field, field.replace("_", " ").capitalize() + ":")
            tk.Label(scrollable_frame, text=label_text, font=("Arial", 10, "bold"), 
                    width=25, anchor="w").grid(row=i, column=0, sticky="w", padx=30, pady=8)
            
            value_text = values[i] if i < len(values) else ""
            tk.Label(scrollable_frame, text=value_text, font=("Arial", 10),
                    width=30, anchor="w", wraplength=300).grid(
                row=i, column=1, sticky="w", padx=30, pady=8
            )
        
        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")
        
        tk.Button(form, text="Cerrar", command=form.destroy, width=15).pack(pady=10)

    def _open_form(self, action, current_values=None):
        """
        Abre un formulario para agregar o editar registros.
        
        Args:
            action (str): Acción a realizar ("Agregar" o "Editar").
            current_values (list, optional): Valores actuales del registro para edición.
        """
        form = tk.Toplevel(self.window)
        form.title(f"{action} Registro")
        entries = {}
        for i, f in enumerate(self.form_fields):
            label_text = self._get_field_labels().get(f, f.replace("_", " ").capitalize() + ":")
            tk.Label(form, text=label_text).grid(row=i, column=0, sticky="w", padx=5, pady=2)
            
            e = tk.Entry(form, width=40)
            e.grid(row=i, column=1, padx=5, pady=2)
            
            if current_values:
                e.insert(0, current_values[i + 1] if self.form_fields != self.fields else current_values[i])
            else:
                placeholder = self._get_placeholder(f)
                if placeholder:
                    e.insert(0, placeholder)
                    e.config(fg="grey")
            
            entries[f] = e

        def save():
            """Guarda los datos del formulario en el archivo CSV."""
            row_from_form = [entries[f].get().strip() for f in self.form_fields]

            if not self.validate(row_from_form):
                return

            final_row = []
            if self.form_fields != self.fields:
                if action == "Agregar":
                    next_id = self._get_next_id()
                    final_row = [str(next_id)] + row_from_form
                else: 
                    original_id = current_values[0]
                    final_row = [original_id] + row_from_form
            else:
                final_row = row_from_form

            rows = []
            try:
                with open(self.filename, newline="", encoding="utf-8") as f:
                    rows = list(csv.reader(f))
                if not rows: rows = [self.fields]
            except FileNotFoundError:
                rows = [self.fields]

            if action == "Editar":
                original_row_list = list(current_values)
                for i, r in enumerate(rows):
                    if r == original_row_list:
                        rows[i] = final_row
                        break
            else:
                rows.append(final_row)

            with open(self.filename, "w", newline="", encoding="utf-8") as f:
                writer = csv.writer(f)
                writer.writerows(rows)

            form.destroy()
            self.load_data()

        tk.Button(form, text="Guardar", command=save).grid(row=len(self.form_fields), column=0, columnspan=2, pady=10)

    def _get_field_labels(self):
        """
        Proporciona etiquetas personalizadas para los campos del formulario.
        
        Returns:
            dict: Diccionario con etiquetas personalizadas para campos específicos.
        """
        return {
            "numero_cuenta": "Número de cuenta:",
            "codigo_entrenador": "Código de entrenador:",
            "pokemon_id": "ID Pokémon:",
            "apellido_pat": "Apellido paterno:", 
            "apellido_mat": "Apellido Materno:",
            "fecha_nac": "Fecha de Nacimiento (DD-MM-YYYY):",
            "cp": "CP:",
            "sexo": "Sexo (M/F/O):",
            "telefonos": "Teléfonos (separados por comas, 10 dígitos c/u):",
            "correos": "Correos (separados por comas, con @):",
            "equipo": "Equipo (Sabiduría/Instinto/Valor):",
            "shiny": "Shiny (True/False):"
        }

    def _get_placeholder(self, field_name):
        """
        Proporciona textos de placeholder para campos del formulario.
        
        Args:
            field_name (str): Nombre del campo.
            
        Returns:
            str: Texto de placeholder para el campo especificado.
        """
        placeholders = {
            "fecha_nac": "DD-MM-YYYY",
            "sexo": "M, F u O",
            "telefonos": "5512345678,5523456789",
            "correos": "usuario@unam.mx,usuario2@ciencias.unam.mx",
            "equipo": "Sabiduría, Instinto o Valor",
            "shiny": "True o False"
        }
        return placeholders.get(field_name)

    def validate(self, row):
        """
        Valida los datos de un registro antes de guardar.
        
        Args:
            row (list): Lista con los valores a validar.
            
        Returns:
            bool: True si la validación es exitosa, False en caso contrario.
        """
        return True  

from .participantes import ParticipanteGUI
from .pokemon import PokemonGUI
from .cuenta import CuentaGUI

def iniciar_gui():
    """
    Inicia la interfaz gráfica principal de la aplicación.
    Crea la ventana principal con botones para acceder a las diferentes secciones.
    """
    root = tk.Tk()
    root.title("Torneo Pokémon Go - Solrock Battle Association")
    root.geometry("500x400")
    tk.Label(root, text="Menú", font=("Arial", 18)).pack(pady=20)
    tk.Button(root, text="Participantes", width=20,
              command=lambda: ParticipanteGUI(root)).pack(pady=5)
    tk.Button(root, text="Cuentas", width=20,
              command=lambda: CuentaGUI(root)).pack(pady=5)
    tk.Button(root, text="Pokemones", width=20,
              command=lambda: PokemonGUI(root)).pack(pady=5)
    tk.Button(root, text="Salir", width=20, command=root.quit).pack(pady=20)
    root.mainloop()