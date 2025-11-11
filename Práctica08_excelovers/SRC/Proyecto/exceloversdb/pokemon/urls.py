"""
Este módulo define los endpoints disponibles para interactuar con los
recursos `Vendedor` y `Alimento` del proyecto Excelovers.
"""

from django.urls import path
from .views import (
    VendedorApiView,
    VendedorApiId,
    AlimentoApiView,
    AlimentoApiId,
)

#: Lista de rutas disponibles en la API.
urlpatterns = [
    # --- Rutas para Vendedor ---
    path('vendedor/', VendedorApiView.as_view()),
    path('vendedor/<int:idpersona>/', VendedorApiId.as_view()),
    # --- Rutas para Alimento ---
    path('alimento/', AlimentoApiView.as_view()),
    path('alimento/<int:idalimento>/', AlimentoApiId.as_view()),
]