import tkinter as tk
from tkinter import ttk, messagebox
import csv, os

class BaseCRUD:
    def __init__(self, root, title, filename, fields, form_fields=None):
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
        tk.Button(frame, text="Refrescar", command=self.load_data).grid(row=0, column=3, padx=5)

        self.load_data()

    def load_data(self):
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
        self._open_form("Agregar")

    def edit(self):
        item = self.tree.selection()
        if not item:
            messagebox.showwarning("Advertencia", "Selecciona un registro para editar")
            return
        values = self.tree.item(item[0], "values")
        self._open_form("Editar", values)

    def delete(self):
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

    def _open_form(self, action, current_values=None):
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
        return {
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
        return True  

from .participantes import ParticipanteGUI
from .pokemon import PokemonGUI
from .cuenta import CuentaGUI

def iniciar_gui():
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