Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # Cuando alguien venga a /products con una petición de tipo GET, le vamos a mandar a un controlador 'products', dentro del controlador existen métodos o acciones, cuando esto es un conjunto (de métodos y acciones) se le llama método index (#index), dentro de ese método se declara la lógica para devolver todos los productos.
  get "/products", to: "products#index"
  get "/products/:id", to: "products#show", as: :product # En /products/ se pasa un identificador de manera dinámica con :id, está url la resolverá el controlador products con el método #show (#show para mostrar un único producto, #index para un conjunto). Luego se declara un método helper para tener un path declarado para cada id del producto, y quitar la necesidad de tener la ruta entera.
end
