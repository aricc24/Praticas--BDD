from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Vendedor, Alimento
from .serializers import VendedorSerializer, AlimentoSerializer

class VendedorApiView(APIView):
    def get(self, request):
        vendedores = Vendedor.objects.all()
        serializer = VendedorSerializer(vendedores, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = VendedorSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class VendedorApiId(APIView):
    def get(self, request, idpersona):
        try:
            vendedor = Vendedor.objects.get(pk=idpersona)
        except Vendedor.DoesNotExist:
            return Response({"error": "Vendedor no encontrado"}, status=status.HTTP_404_NOT_FOUND)

        serializer = VendedorSerializer(vendedor)
        return Response(serializer.data)

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

    def delete(self, request, idpersona):
        try:
            vendedor = Vendedor.objects.get(pk=idpersona)
        except Vendedor.DoesNotExist:
            return Response({"error": "Vendedor no encontrado"}, status=status.HTTP_404_NOT_FOUND)

        vendedor.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


class AlimentoApiView(APIView):

    def get(self, request):
        alimentos = Alimento.objects.all()
        serializer = AlimentoSerializer(alimentos, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = AlimentoSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class AlimentoApiId(APIView):

    def get(self, request, idalimento):
        try:
            alimento = Alimento.objects.get(pk=idalimento)
        except Alimento.DoesNotExist:
            return Response({"error": "Alimento no encontrado"}, status=status.HTTP_404_NOT_FOUND)

        serializer = AlimentoSerializer(alimento)
        return Response(serializer.data)

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

    def delete(self, request, idalimento):
        try:
            alimento = Alimento.objects.get(pk=idalimento)
        except Alimento.DoesNotExist:
            return Response({"error": "Alimento no encontrado"}, status=status.HTTP_404_NOT_FOUND)

        alimento.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
