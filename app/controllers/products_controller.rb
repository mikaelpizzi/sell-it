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
            render :new, status: :unprocessable_entity # Returns 422
        end
    end
    
    
    def edit
        @product = Product.find(params[:id])
    end
    
    def update
        @product = Product.find(params[:id])
        
        if @product.update(product_params) # Specify which params you want to update
            redirect_to products_path, notice: "The product was edited successfully"
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @product = Product.find(params[:id])
        @product.destroy
        # redirect_to returns 302 by default, a DELETE request with turbo can not handle that, see_other returns a 303, it does not link you to the current product (that is what we want, because the actual product was deleted)
        redirect_to products_path, notice: "The product was deleted successfully", status: :see_other
    end

    private

    def product_params
        params.require(:product).permit(:title, :description, :price, :photo)
    end
end

# Modelo: Todo con respecto a la base de datos, consultas, validaciones, relaciones
# Vista: Devolver al usuario html, JSON, un pdf, csv
# Controlador: Lógica