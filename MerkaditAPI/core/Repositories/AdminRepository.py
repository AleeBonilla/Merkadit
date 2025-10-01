from .BaseRepository import BaseRepository

class AdminRepository(BaseRepository):
    def __init__(self):
        super().__init__()

    def settleCommerce(self, local: str, comercio:str, mes: int = None):
        cursor = self.CreateCursor()
        print(local, comercio)
        query = f"call settleCommerce('{comercio}', '{local}', {mes if mes is not None else "NULL"})"
        print(query)
        cursor.execute(query)
        result = {
            "rowcount": cursor.rowcount,
            "warnings": cursor.warnings,
            "result": cursor.fetchall()

        }
        return result

AdminRepo = AdminRepository()