import tkinter as tk
from tkinter import ttk, messagebox
import csv, os


class BaseCRUD:
    def __init__(self, root, title, filename, fields):
        self.filename = filename
        self.fields = fields

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
                for row in reader:
                    self.tree.insert("", "end", values=row)
        except FileNotFoundError:
            with open(self.filename, "w", newline="", encoding="utf-8") as f:
                writer = csv.writer(f)
                writer.writerow(self.fields)

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
        for i, f in enumerate(self.fields):
            tk.Label(form, text=f.replace("_", " ").capitalize()).grid(row=i, column=0, sticky="w")
            e = tk.Entry(form, width=40)
            e.grid(row=i, column=1)
            if current_values:
                e.insert(0, current_values[i])
            entries[f] = e

        def save():
            row = [entries[f].get().strip() for f in self.fields]

            if not self.validate(row):
                return

            rows = []
            try:
                with open(self.filename, newline="", encoding="utf-8") as f:
                    rows = list(csv.reader(f))
            except FileNotFoundError:
                rows = [self.fields]

            if action == "Editar":
                for i, r in enumerate(rows):
                    if r == list(current_values):
                        rows[i] = row
            else:
                rows.append(row)

            with open(self.filename, "w", newline="", encoding="utf-8") as f:
                writer = csv.writer(f)
                writer.writerows(rows)

            form.destroy()
            self.load_data()

        tk.Button(form, text="Guardar", command=save).grid(row=len(self.fields), column=0, columnspan=2)

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
