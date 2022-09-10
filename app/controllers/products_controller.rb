class ProductsController < ApplicationController
    def index
        @products = Product.all
    end

    def show
        @product = Product.find(params[:id])
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)

        if @product.save
            redirect_to products_path, notice: "The product was created successfully"
        else
            render :new, status: :unprocessable_entity # Devuelve 422
        end
    end

    def product_params
        params.require(:product).permit(:title, :description, :price)
    end
end

# Modelo: Todo con respecto a la base de datos, consultas, validaciones, relaciones
# Vista: Devolver al usuario html, JSON, un pdf, csv
# Controlador: Lógica