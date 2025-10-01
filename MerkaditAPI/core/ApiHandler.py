from flask import Flask
from Handlers.SalesHandler import SalesBlueprint

app = Flask(__name__)


# agregar acá todos los blueprints con sus prefijos respectivos
app.register_blueprint(SalesBlueprint, url_prefix='/sales')

if __name__ == '__main__':
    print(app.url_map)
    app.run(debug = True)