from presentation.cli import CLI

def main():
    try:
        app = CLI()
        app.run()
    except Exception as e:
        print(f"Error al iniciar la aplicación: {e}")

if __name__ == "__main__":
    try: 
        main()
    except KeyboardInterrupt:
        print("\nSaliendo... BYE :)!")