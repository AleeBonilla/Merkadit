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
    print(request.json)
    comercio: str = request.form.get("comercio")
    cantidad: int = request.form.get("cantidad")
    monto: float = request.form.get("monto")
    numReferencia: int = request.form.get("num-referencia")
    numFactura: int = request.form.get("num-factura")
    cliente: str = request.form.get("cliente")
    descuento: float = request.form.get("descuento")
    
    return request.json