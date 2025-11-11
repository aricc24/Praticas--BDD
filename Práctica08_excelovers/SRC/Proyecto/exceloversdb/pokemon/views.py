
"""
Vistas de la API REST para la aplicación 'pokemon'.

Este módulo define las clases que gestionan las operaciones CRUD
(Create, Read, Update, Delete) para los modelos `Vendedor` y `Alimento`.
Cada clase hereda de `rest_framework.views.APIView` y responde a
solicitudes HTTP (GET, POST, PUT, DELETE) utilizando los serializadores
correspondientes.
"""
from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Vendedor, Alimento
from .serializers import VendedorSerializer, AlimentoSerializer

"""
Vistas de la API REST para la aplicación 'pokemon'.

Este módulo define las clases que gestionan las operaciones CRUD
(Create, Read, Update, Delete) para los modelos `Vendedor` y `Alimento`.
Cada clase hereda de `rest_framework.views.APIView` y responde a
solicitudes HTTP (GET, POST, PUT, DELETE) utilizando los serializadores
correspondientes.
"""

class VendedorApiView(APIView):
    """
     Obtener la lista completa de vendedores.

    Método HTTP: GET  
    Endpoint: `/api/vendedor/`

     Returns:
     Response: Lista de todos los vendedores serializados con código 200 (OK).
    """
    def get(self, request):
        vendedores = Vendedor.objects.all()
        serializer = VendedorSerializer(vendedores, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    """
    Crear un nuevo vendedor.

    Método HTTP: POST  
    Endpoint: `/api/vendedor/`

    Returns:
         Response: Datos del vendedor creado con código 201 (Created)
        o errores de validación con código 400 (Bad Request).
    """
    def post(self, request):
        serializer = VendedorSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

"""
Vista API para operaciones sobre un vendedor específico.

Gestiona las solicitudes dirigidas a `/api/vendedor/<idpersona>/`.
Permite obtener, actualizar o eliminar un vendedor existente.
"""
class VendedorApiId(APIView):

    """
    Obtener la información de un vendedor por su ID.

    Método HTTP: GET  
    Endpoint: `/api/vendedor/<idpersona>/`

    Returns:
        Response: Datos del vendedor si existe (200),
        o mensaje de error si no se encuentra (404).
    """
    def get(self, request, idpersona):
        try:
            vendedor = Vendedor.objects.get(pk=idpersona)
        except Vendedor.DoesNotExist:
            return Response({"error": "Vendedor no encontrado"}, status=status.HTTP_404_NOT_FOUND)

        serializer = VendedorSerializer(vendedor)
        return Response(serializer.data)

    """
    Actualizar la información de un vendedor existente.

    Método HTTP: PUT  
    Endpoint: `/api/vendedor/<idpersona>/`

     Returns:
        Response: Datos actualizados del vendedor (200)
        o error de validación o inexistencia (400 / 404).
    """
    def put(self, request, idpersona):
        try:
            vendedor = Vendedor.objects.get(pk=idpersona)
        except Vendedor.DoesNotExist:
            return Response({"error": "Vendedor no encontrado"}, status=status.HTTP_404_NOT_FOUND)

        serializer = VendedorSerializer(vendedor, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


    """
    Eliminar un vendedor por su ID.

    Método HTTP: DELETE  
    Endpoint: `/api/vendedor/<idpersona>/`

    Returns:
        Response: Sin contenido (204) si se elimina con éxito,
        o mensaje de error si no se encuentra (404).
    """
    def delete(self, request, idpersona):
        try:
            vendedor = Vendedor.objects.get(pk=idpersona)
        except Vendedor.DoesNotExist:
            return Response({"error": "Vendedor no encontrado"}, status=status.HTTP_404_NOT_FOUND)

        vendedor.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

"""
Vista API para la colección de alimentos.

Gestiona las solicitudes HTTP dirigidas a la URL `/api/alimento/`.
Permite listar todos los alimentos (GET) y crear nuevos registros (POST).
"""
class AlimentoApiView(APIView):

    """
    Obtener la lista completa de alimentos.

    Método HTTP: GET  
    Endpoint: `/api/alimento/`

    Returns:
        Response: Lista de alimentos serializados (200 OK).
    """
    def get(self, request):
        alimentos = Alimento.objects.all()
        serializer = AlimentoSerializer(alimentos, many=True)
        return Response(serializer.data)

    """
    Crear un nuevo alimento.

    Método HTTP: POST  
    Endpoint: `/api/alimento/`

    Returns:
        Response: Datos del alimento creado (201 Created)
        o errores de validación (400 Bad Request).
    """
    def post(self, request):
        serializer = AlimentoSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

"""
Vista API para operaciones sobre un alimento específico.

Gestiona las solicitudes dirigidas a `/api/alimento/<idalimento>/`.
Permite obtener, actualizar o eliminar un alimento existente.
"""
class AlimentoApiId(APIView):

    """
    Obtener un alimento por su ID.

    Método HTTP: GET  
    Endpoint: `/api/alimento/<idalimento>/`

    Returns:
        Response: Datos del alimento (200 OK)
        o mensaje de error si no se encuentra (404 Not Found).
    """
    def get(self, request, idalimento):
        try:
            alimento = Alimento.objects.get(pk=idalimento)
        except Alimento.DoesNotExist:
            return Response({"error": "Alimento no encontrado"}, status=status.HTTP_404_NOT_FOUND)

        serializer = AlimentoSerializer(alimento)
        return Response(serializer.data)

    """
    Actualizar la información de un alimento existente.

    Método HTTP: PUT  
    Endpoint: `/api/alimento/<idalimento>/`

    Returns:
        Response: Datos actualizados del alimento (200)
        o mensaje de error si no existe o los datos son inválidos (404 / 400).
    """
    def put(self, request, idalimento):
        try:
            alimento = Alimento.objects.get(pk=idalimento)
        except Alimento.DoesNotExist:
            return Response({"error": "Alimento no encontrado"}, status=status.HTTP_404_NOT_FOUND)

        serializer = AlimentoSerializer(alimento, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    """
    Eliminar un alimento por su ID.

    Método HTTP: DELETE  
    Endpoint: `/api/alimento/<idalimento>/`

    Returns:
        Response: Sin contenido (204 No Content) si se elimina con éxito,
        o mensaje de error si no se encuentra (404 Not Found).
    """
    def delete(self, request, idalimento):
        try:
            alimento = Alimento.objects.get(pk=idalimento)
        except Alimento.DoesNotExist:
            return Response({"error": "Alimento no encontrado"}, status=status.HTTP_404_NOT_FOUND)

        alimento.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
