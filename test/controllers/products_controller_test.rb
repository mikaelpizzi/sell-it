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

    test "Render an edit product form" do
        get edit_product_path(products(:ps5))

        assert_response :success
        assert_select "form"
    end

    test "Allow to edit a product" do
        patch product_path(products(:ps5)), params: {
            product: {
                price: 750
            }
        }
        
        assert_redirected_to products_path
        assert_equal flash[:notice], "The product was edited successfully"
    end

    test "Does not allow to edit a product with an invalid field" do
        patch product_path(products(:ps5)), params: {
            product: {
                price: nil
            }
        }
        
        assert_response :unprocessable_entity
    end
    #(Count products, expected result)
    test "Can delete products" do
        assert_difference("Product.count", -1) do 
            delete product_path(products(:ps5))
        end

        assert_redirected_to products_path
        assert_equal flash[:notice], "The product was deleted successfully"
    end
end