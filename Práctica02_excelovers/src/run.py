import sys
from presentation.cli import CLI
from presentation.gui import gui 

def main() -> None:
    """
    Función principal que inicia la aplicación.
    """
    if len(sys.argv) > 1 and sys.argv[1].lower() == "gui":
        gui.iniciar_gui()
    else:
        app = CLI()
        app.run()

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nSaliendo... BYE :)!")
    except Exception as e:
        print(f"Error al iniciar la aplicación: {e}")
