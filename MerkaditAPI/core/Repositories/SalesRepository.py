from .BaseRepository import BaseRepository

class SalesRepository(BaseRepository):
    def __init__(self):
        super().__init__()
    
    def Test(self):
        cursor = self.CreateCursor()
        cursor.execute("SHOW DATABASES")
        conns = []
        for i in cursor.fetchall():
            conns.append(i)
        return conns

    def RegisterSale(self, saleDict: dict):
        cursor = self.CreateCursor()
        query = f"""CALL registerSale(
            '{saleDict.get("nombre_producto")}',
            '{saleDict.get("nombre_tienda")}',
            {saleDict.get("cantidad_vendida")},
            {saleDict.get("monto_pagado")},
            '{saleDict.get("metodo_pago")}',
            '{saleDict.get("confirmaciones_pago")}',
            {saleDict.get("numeros_referencia")},
            '{saleDict.get("cedula_cliente")}',
            '{saleDict.get("nombre_cliente")}',
            {saleDict.get("descuentos_aplicados")},
            {saleDict.get("user_id")},
            '{saleDict.get("computer_name")}'
        );"""
        print(query)
        cursor.execute(query)
        result = {
            "rowcount": cursor.rowcount,
            "warnings": cursor.warnings,
            "result": cursor.fetchall()
        }
        return result

SalesRepo = SalesRepository()