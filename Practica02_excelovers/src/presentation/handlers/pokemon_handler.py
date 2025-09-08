from utils.validators.validators import validate_integer, validate_string, validate_sexo, validate_input, validate_float
from domain.entities.pokemon import Sexo

class PokemonHandler:
    def __init__(self, pokemon_service):
        self.pokemon_service = pokemon_service


    def add_pokemon(self):
        print("Agregar Pokémon")
        nombre = validate_input(input("Nombre: "), validate_string, "Nombre")
        especie = validate_input(input("Especie: "), validate_string, "Especie")
        tipo = validate_input(input("Tipo: "), validate_string, "Tipo")
        cp = validate_input(input("CP: "), validate_integer, "CP")
        peso = validate_input(input("Peso: "), validate_float, "Peso")
        sexo = Sexo(validate_input(input("Sexo (M/F/O): "), validate_sexo, "Sexo"))
        shiny = validate_input(input("Es shiny? (s/n): "), lambda x, y: x.lower() == "s" or x.lower() == "n", "Shiny (s/n)")
        try: 
            pokemon = self.pokemon_service.add_pokemon(nombre, especie, tipo, cp, peso, sexo, shiny)
            print(f"Pokémon creado exitosamente: {pokemon.pokemon_id}")
        except Exception as e:
            print(f"Error al crear el Pokémon: {e}")

    def retrieve_pokemon(self):
        print("Consultar Pokémon")
        pokemon_id = validate_input(input("ID del Pokémon: "), validate_integer, "ID")
        try:
            pokemon = self.pokemon_service.get_pokemon(pokemon_id)
            if pokemon:
                print("Información del Pokémon:")
                print(pokemon)
            else:
                print("Pokémon no encontrado.")
        except Exception as e:
            print(f"Error al consultar el Pokémon: {e}")

    def delete_pokemon(self):
        print("Eliminar Pokémon")
        pokemon_id = validate_input(input("ID del Pokémon a eliminar: "), validate_integer, "ID")
        try:
            self.pokemon_service.delete_pokemon(pokemon_id)
            print("Pokémon eliminado exitosamente.")
        except Exception as e:
            print(f"Error al eliminar el Pokémon: {e}")

    def update_pokemon(self):
        print("Editar Pokémon")
        pokemon_id = validate_integer(input("ID del Pokémon a editar: "), "ID")
        try:
            pokemon = self.pokemon_service.get_pokemon(pokemon_id)
        except Exception as e:
            print(f"No se encontró el Pokémon: {e}")
            return

        nombre = validate_input(
            input(f"Nombre [{pokemon.nombre}]: "),
            lambda x, y: validate_string(x, y) if x.strip() else pokemon.nombre,
            "Nombre"
        )
        especie = validate_input(
            input(f"Especie [{pokemon.especie}]: "),
            lambda x, y: validate_string(x, y) if x.strip() else pokemon.especie,
            "Especie"
        )
        tipo = validate_input(
            input(f"Tipo [{pokemon.tipo}]: "),
            lambda x, y: validate_string(x, y) if x.strip() else pokemon.tipo,
            "Tipo"
        )
        cp = validate_input(
            input(f"CP [{pokemon.cp}]: "),
            lambda x, y: validate_integer(x, y) if x.strip() else pokemon.cp,
            "CP"
        )
        peso = validate_input(
            input(f"Peso [{pokemon.peso}]: "),
            lambda x, y: float(x) if x.strip() else pokemon.peso,
            "Peso"
        )
        sexo = validate_input(
            input(f"Sexo (M/F/O) [{pokemon.sexo.value}]: "),
            lambda x, y: validate_sexo(x, y) if x.strip() else pokemon.sexo,
            "Sexo"
        )
        shiny_input = input(f"Shiny (s/n) [{pokemon.shiny}]: ").strip()
        shiny = pokemon.shiny if shiny_input == "" else shiny_input.lower() == "s"

        try:
            pokemon_actualizado = self.pokemon_service.update_pokemon(
                pokemon_id,
                nombre,
                especie,
                tipo,
                cp,
                peso,
                sexo,
                shiny
            )
            print(f"Pokémon actualizado exitosamente: {pokemon_actualizado.pokemon_id}")
        except Exception as e:
            print(f"Error al actualizar el Pokémon: {e}")
