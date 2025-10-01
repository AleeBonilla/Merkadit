from Controllers.AdminController import AdminCtrl
from flask import Blueprint
from flask import request

AdminBlueprint = Blueprint('admin', __name__)

@AdminBlueprint.route('/settleCommerce', methods=["POST"])
def settleCommerce():
    print(request.json)
    comercio: str = request.form.get("comercio")
    local: str = request.form.get("local")
    mes: int = request.form.get("mes")
    
    return AdminCtrl.settleCommerce(comercio, local, mes)