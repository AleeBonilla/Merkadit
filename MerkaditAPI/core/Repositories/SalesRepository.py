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

    def RegisterSale(self):
        cursor = self.CreateCursor()
        cursor.execute("EXECUTE registerSale")
        pass

SalesRepo = SalesRepository()