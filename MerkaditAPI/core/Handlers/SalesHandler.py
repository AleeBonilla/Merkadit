from Controllers.SalesController import SalesCtrl
from flask import Blueprint
from flask import request

SalesBlueprint = Blueprint('sales', __name__)

@SalesBlueprint.route('')
def Show():
    try:
        a = ""
        for i in SalesCtrl.Test():
            print(i)
            a = a + str(i) + "</br>"
        return a
    except Exception:
        return ""

@SalesBlueprint.route('/registerSale', methods=["POST"])
def RegisterSale():
    print(type(request.json))
    salesDict = request.json
    
    return SalesCtrl.RegisterSale(salesDict)

test = {
    "nombre_producto": 'Set de Lego City',
    "nombre_tienda": 'Juguetería Feliz',
    "cantidad_vendida":  2,
    "monto_pagado":  56500.0,
    "metodo_pago": "EFECTIVO",
    "confirmaciones_pago": {"confirmado": True},
    "numeros_referencia": 123456789,
    "cedula_cliente": '304560789',
    "nombre_cliente":  'Juan Pérez',
    "descuentos_aplicados": 0.0,
    "user_id": 100,
    "computer_name": 'CAJA-01'
}