from Services.SalesService import SalesServ

class SalesController:
    def __init__(self):
        pass

    def Test(self): 
        return SalesServ.Test()
    
    def GetSales(self, test: int) -> str:
        pass

    def RegisterSale(self, saleDict):
        return SalesServ.RegisterSale(saleDict)

SalesCtrl = SalesController()
    
