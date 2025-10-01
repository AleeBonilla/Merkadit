from Services.AdminService import AdminServ

class AdminController:
    def __init__(self):
        pass
    
    def settleCommerce(self, local, comercio, mes):
        return AdminServ.settleCommerce(local, comercio, mes)

AdminCtrl = AdminController()
    
