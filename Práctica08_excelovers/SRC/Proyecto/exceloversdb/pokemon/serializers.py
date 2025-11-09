from rest_framework import serializers
from .models import Vendedor, Alimento

class VendedorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vendedor
        fields = '__all__'

class AlimentoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Alimento
        fields = '__all__'
