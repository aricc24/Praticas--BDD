"""
Este módulo define los serializadores utilizados para convertir las instancias
de los modelos `Vendedor` y `Alimento` en representaciones JSON
"""

from rest_framework import serializers
from .models import Vendedor, Alimento

"""
Este serializador convierte las instancias del modelo `Vendedor`
a formato JSON, y también permite crear o actualizar registros
mediante peticiones HTTP (POST y PUT).

Atributos:
    Meta (class): Clase interna que define la configuración del serializador.
        - model: Indica que el serializador está basado en el modelo `Vendedor`.
        - fields: Define los campos que se incluirán en la serialización.
        En este caso, se incluyen todos los campos del modelo mediante `'__all__'`.
"""
class VendedorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vendedor
        fields = '__all__'

"""
Este serializador gestiona la conversión de los objetos `Alimento`
a formato JSON, así como la validación de los datos provenientes
de la API antes de ser guardados en la base de datos.

Atributos:
    Meta (class): Clase interna que define la configuración del serializador.
        - model: Indica que el serializador está basado en el modelo `Alimento`.
        - fields: Define los campos que se incluirán en la serialización.
        En este caso, se incluyen todos los campos del modelo mediante `'__all__'`.
"""
class AlimentoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Alimento
        fields = '__all__'
