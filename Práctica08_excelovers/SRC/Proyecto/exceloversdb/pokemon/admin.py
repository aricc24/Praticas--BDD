from django.contrib import admin
from .models import Vendedor, Alimento

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
