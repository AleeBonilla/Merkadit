from flask import Flask
from Handlers.SalesHandler import SalesBlueprint
from Handlers.AdminHandler import AdminBlueprint

app = Flask(__name__)


# agregar acá todos los blueprints con sus prefijos respectivos
app.register_blueprint(SalesBlueprint, url_prefix='/sales')
app.register_blueprint(AdminBlueprint, url_prefix='/admin')

if __name__ == '__main__':
    print(app.url_map)
    app.run(debug = True)