Rails.application.routes.draw do
  namespace "api" do
    namespace "v1" do
      get "/comics", to: "comics#index"
      resources :users
      post "/login", to: "users#login"
      get "/auto_login", to: "users#auto_login"
      resources :comics
    end
  end
end
