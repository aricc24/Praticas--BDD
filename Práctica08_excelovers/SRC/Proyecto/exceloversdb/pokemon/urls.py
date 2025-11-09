from django.urls import path
from .views import (
    VendedorApiView,
    VendedorApiId,
    AlimentoApiView,
    AlimentoApiId,
)

urlpatterns = [
    path('vendedor/', VendedorApiView.as_view()),
    path('vendedor/<int:idpersona>/', VendedorApiId.as_view()),
    path('alimento/', AlimentoApiView.as_view()),
    path('alimento/<int:idalimento>/', AlimentoApiId.as_view()),
]