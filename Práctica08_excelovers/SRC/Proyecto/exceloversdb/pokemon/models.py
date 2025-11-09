# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Vendedor(models.Model):
    idpersona = models.AutoField(primary_key=True, db_comment='Identificador único del vendedor (PK).')
    nombre = models.CharField(max_length=100, db_comment='Nombre del vendedor.')
    apellidomaterno = models.CharField(max_length=100, db_comment='Apellido materno del vendedor.')
    apellidopaterno = models.CharField(max_length=100, db_comment='Apellido paterno del vendedor.')
    fechanacimiento = models.DateField(db_comment='Fecha de nacimiento del vendedor.')
    sexo = models.CharField(max_length=10, db_comment='Sexo del vendedor.')
    calle = models.CharField(max_length=100, db_comment='Calle de residencia del vendedor.')
    colonia = models.CharField(max_length=100, db_comment='Colonia de residencia del vendedor.')
    ciudad = models.CharField(max_length=100, db_comment='Ciudad de residencia del vendedor.')
    codigopostal = models.IntegerField(db_comment='Código postal del vendedor.')
    numinterior = models.IntegerField(db_comment='Número interior del vendedor.')
    numexterior = models.IntegerField(db_comment='Número exterior del vendedor.')
    ubicacion = models.CharField(max_length=100, db_comment='Ubicación asignada del vendedor.')

    class Meta:
        managed = False
        db_table = 'vendedor'
        db_table_comment = 'Tabla para almacenar la información de los venderores.'


class Alimento(models.Model):
    idalimento = models.AutoField(primary_key=True, db_comment='Identificador único del alimento.')
    idpersona = models.ForeignKey(Vendedor, models.DO_NOTHING, db_column='idpersona', db_comment='Identificador del vendedor que ofrece el alimento (llave foránea hacia Vendedor).')
    fechadecaducidad = models.DateField(db_comment='Fecha de caducidad del alimento.')
    nombre = models.CharField(max_length=20, db_comment='Nombre del alimento.')
    tipo = models.CharField(max_length=20, db_comment='Tipo o categoría del alimento.')
    precio = models.FloatField(db_comment='Precio del alimento; debe ser un valor positivo.')

    class Meta:
        managed = False
        db_table = 'alimento'
        db_table_comment = 'Tabla que contiene los alimentos ofrecidos por los vendedores en el evento.'
