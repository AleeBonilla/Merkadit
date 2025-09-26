from Controllers.SalesController import SalesCtrl
from flask import Blueprint

SalesBlueprint = Blueprint('sales', __name__)

@SalesBlueprint.route('')
def show():
    try:
        a = ""
        for i in SalesCtrl.Test():
            print(i)
            a = a + str(i) + "</br>"
        return a
    except Exception:
        return ""