from Repositories.AdminRepository import AdminRepo

class AdminService:
    def __init__(self):
        pass

    def settleCommerce(self, local, comercio, mes):
        return AdminRepo.settleCommerce(local, comercio, mes)
    
AdminServ = AdminService()