require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
    test "Render a list of products" do
        get products_path

        assert_response :success
        assert_select ".product", 2
    end

    test "Render a detail product page" do
        get product_path(products(:redmi))

        assert_response :success
        assert_select ".title", "Redmi K40"
        assert_select ".description", "Cool phone 12gb ram 256gb rom, like new"
        assert_select ".price", "380$"
    end

    test "Render a new product form" do
        get new_product_path

        assert_response :success
        assert_select "form"
    end

    test "Allow to create a new product" do
        post products_path, params: {
            product: {
                title: "Nintendo 64",
                description: "Used, but still playable",
                price: 45
            }
        }
        
        assert_redirected_to products_path
        assert_equal flash[:notice], "The product was created successfully"
    end

    test "Does not allow to create a new product with empty fields" do
        post products_path, params: {
            product: {
                title: "",
                description: "Used, but still playable",
                price: 45
            }
        }
        
        assert_response :unprocessable_entity
    end
end