"""
Configuración del panel de administración de Django para los modelos
Vendedor y Alimento del proyecto Excelovers.
"""

from django.contrib import admin
from .models import Vendedor, Alimento

"""
Clase que personaliza la forma en que se despliega la información
de los vendedores en el administrador de Django.
"""
@admin.register(Vendedor)
class VendedorAdmin(admin.ModelAdmin):
    list_display = (
        'idpersona',
        'nombre',
        'apellidopaterno',
        'apellidomaterno',
        'fechanacimiento',
        'sexo',
        'calle',
        'colonia',
        'ciudad',
        'codigopostal',
        'numinterior',
        'numexterior',
        'ubicacion',
    )

"""
Clase que personaliza la forma en que se despliega la información
de los alimentos en el administrador de Django.
"""
@admin.register(Alimento)
class AlimentoAdmin(admin.ModelAdmin):
    list_display = (
        'idalimento',
        'idpersona',
        'fechadecaducidad',
        'nombre',
        'tipo',
        'precio',
    )
