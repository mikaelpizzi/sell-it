class ProductsController < ApplicationController
    def index
        @products = Product.all
    end
end

# Modelo: Todo con respecto a la base de datos, consultas, validaciones, relaciones
# Vista: Devolver al usuario html, JSON, un pdf, csv
# Controlador: Lógica