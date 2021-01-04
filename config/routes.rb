Rails.application.routes.draw do
  namespace "api" do
    namespace "v1" do
      get "/comics", to: "comics#index"
      resources :users
    end
  end
end
