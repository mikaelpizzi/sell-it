class ProductsController < ApplicationController
    def index
        @products = Product.all.with_attached_photo
    end

    def show
        product
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)

        if @product.save
            redirect_to products_path, notice: t(".created")
        else
            render :new, status: :unprocessable_entity # Returns 422
        end
    end
    
    
    def edit
        product
    end
    
    def update
        if product.update(product_params) # Specify which params you want to update
            redirect_to products_path, notice: t(".updated")
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        product.destroy
        # redirect_to returns 302 by default, a DELETE request with turbo can not handle that, see_other returns a 303, it does not link you to the current product (that is what we want, because the actual product was deleted)
        redirect_to products_path, notice: t(".destroyed"), status: :see_other
    end

    private

    def product_params
        params.require(:product).permit(:title, :description, :price, :photo)
    end

    def product
        @product = Product.find(params[:id])
    end
end

# Modelo: Todo con respecto a la base de datos, consultas, validaciones, relaciones
# Vista: Devolver al usuario html, JSON, un pdf, csv
# Controlador: Lógica