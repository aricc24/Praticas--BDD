"""
Módulo que define la clase de configuración de la aplicación, la cual
permite registrar la app en el sistema de Django y ajustar parámetros
como el campo automático por defecto para los modelos.
"""

from django.apps import AppConfig

"""
Esta clase define la configuración básica necesaria para que
Django reconozca y gestione la aplicación. Hereda de
`django.apps.AppConfig`.
"""
class PokemonConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'pokemon'
