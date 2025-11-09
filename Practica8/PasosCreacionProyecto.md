# Pasos realizados para la creación del proyecto

(Esto es lo que le moví)

Posicionarse en la carpeta `./Práctica08_excelovers/SRC/Proyecto` inicialmente vacía

1. Crear el entorno 

```sh
python3 -m venv venv
source venv/bin/activate 
pip install django djangorestframework psycopg2-binary
```

Nota: Con `deactivate` sales del entorno, pero no te salgas.

2. Crear proyecto  Django

```sh
django-admin startproject exceloversdb
cd exceloversdb
python manage.py startapp pokemon
```

debe verse así 

```sh
(venv) [j_zarcoo@fedora exceloversdb]$ tree
.
├── exceloversdb
│   ├── asgi.py
│   ├── __init__.py
│   ├── __pycache__
│   │   ├── __init__.cpython-311.pyc
│   │   └── settings.cpython-311.pyc
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── manage.py
└── pokemon
    ├── admin.py
    ├── apps.py
    ├── __init__.py
    ├── migrations
    │   └── __init__.py
    ├── models.py
    ├── tests.py
    └── views.py

5 directories, 15 files
```

3. Crear nuevo contenedor de Docker limpio
   
```sh
# Eliminar si ya existe
# docker rm -f excelovers

docker run --name excelovers -e POSTGRES_USER=excelovers_user -e POSTGRES_PASSWORD=excelovers_123 -e POSTGRES_DB=excelovers_db -p 5432:5432 -d postgres
```

verificar que esté corriendo 

```sh
docker ps
```
debe verse asi
```sh
CONTAINER ID   IMAGE      COMMAND                  CREATED          STATUS          PORTS                                       NAMES
54b157bb2215   postgres   "docker-entrypoint.s…"   56 seconds ago   Up 55 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   excelovers
```

puedes entrar así

```sh
sudo docker exec -it excelovers psql -U excelovers_user -d excelovers_db
```

el comando para salir es `\q`


4. Copiar archivos al contenedor de PostgreSQL

```sh
docker cp ../../../SQL/DDL.sql excelovers:/DDL.sql
docker cp ../../../SQL/DML.sql excelovers:/DML.sql

# Successfully copied 102kB to excelovers:/DDL.sql
# Successfully copied 640kB to excelovers:/DML.sql
```

- Entrar al contenedor (para salir `exit`)

```sh
docker exec -it excelovers bash
```

- Dentro, iniciar psql como usuario

```sh
psql -U excelovers_user -d excelovers_db
```

- Ejecutar scripts `.sql`

```sh
\i /DDL.sql;
\i /DML.sql;
```

5. Configurar `exceloversdb/settings.py`
   
```py
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'excelovers_db',
        'USER': 'excelovers_user',
        'PASSWORD': 'excelovers_123',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
```

6. Registrar la app en `exceloversdb/settings.py`

```py
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'pokemon',
]
```

7. Crear modelos de las tablas

El comando `inspectdb` lee la base de datos PostgreSQL (`excelovers_db`) y genera clases Django (`models.Model`) en `pokemon/models.py` que representan las tablas SQL.

Ejecuta dentro de `./Práctica08_excelovers/SRC/Proyecto/exceloversdb`
```sh
# Todas las tablas
# python manage.py inspectdb > pokemon/models.py

# Generar modelo solo de vendedor y alimento
python manage.py inspectdb vendedor alimento > pokemon/models.py
```

8. Crear serializers y vistas REST

Ejemplo con vendedor y alimento

- En el archivo `pokemon/serializers.py` (si no existe, crealo)

```py
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
```

- En el archivo `pokemon/views.py` (si no existe, crealo) definir los métodos CRUD


<!--   Te ahorra la chamba que justamente es el objetivo de la práctica creo

  - Usar un `ViewSet` de Django REST Framework para tener CRUD automático.

```py
from rest_framework import viewsets
from .models import Vendedor
from .serializers import VendedorSerializer

class VendedorViewSet(viewsets.ModelViewSet):
    queryset = Vendedor.objects.all()
    serializer_class = VendedorSerializer
``` -->

```py
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

```

- En el archivo `pokemon/urls.py` (si no existe, crealo) 
<!-- Te ahorra la chamba que justamente es el objetivo de la práctica creo
```py
from rest_framework import routers
from .views import VendedorViewSet

router = routers.DefaultRouter()
router.register(r'vendedores', VendedorViewSet)

urlpatterns = router.urls
``` -->

```py
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
```

- Enlazar en `exceloversdb/urls.py`

```py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('pokemon.urls')),
]
```

9. Registrar el modelo en Django Admin

En `pokemon/admin.py`

```py
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
```

10. Migraciones

```sh
python manage.py makemigrations
```
debe salir algo así
```sh
Migrations for 'pokemon':
  pokemon/migrations/0001_initial.py
    + Create model Alimento
    + Create model Vendedor
```
```sh
python manage.py migrate
```
debe salir algo así
```shOperations to perform:
  Apply all migrations: admin, auth, contenttypes, pokemon, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying auth.0012_alter_user_first_name_max_length... OK
  Applying pokemon.0001_initial... OK
  Applying sessions.0001_initial... OK
```

11.  Superusuario

- Correo: exceloverss@gmail.com
- Contraseña: LAXJAg$r4

```sh
(venv) [j_zarcoo@fedora exceloversdb]$ python manage.py createsuperuser
Username (leave blank to use 'j_zarcoo'): excelover
Email address: exceloverss@gmail.com
Password: 
Password (again): 
Superuser created successfully.
```

12.  Levantar el Servidor 

```sh
python manage.py runserver
```

# * Instalar Postman

Descargar en [Postman](https://www.postman.com/downloads/)

```sh
sudo tar -xzf postman-linux-x64.tar.gz -C /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman
```

Iniciar postman
```sh
postman
```
Probar Api
![Postman](image.png)

Finalmente, obtener archivo de dependencias
```sh
pip freeze > requirements.txt
```
