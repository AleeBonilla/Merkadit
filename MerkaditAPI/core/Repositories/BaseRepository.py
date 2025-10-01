import mysql.connector

class BaseRepository:
    def __init__(self):
        self.DBConnection = mysql.connector.connect(
            host="localhost", port=3306,
            user="root", password="123456",
            database="Merkadit"
        )

    def CreateCursor(self):
        return self.DBConnection.cursor()
    
    def __del__(self):
        pass
        #self.DBConnection.close()