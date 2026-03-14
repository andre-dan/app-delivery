Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Existing web UI
  root "menu#index"
  get "menu",          to: "menu#index",    as: :menu
  get "menu/products", to: "menu#products", as: :menu_products

  # ── API v1 ────────────────────────────────────────────────────────────────
  namespace :api do
    namespace :v1 do
      # Auth (no authentication required)
      post   "auth/register", to: "auth#register"
      post   "auth/login",    to: "auth#login"
      post   "auth/refresh",  to: "auth#refresh"

      # Current user profile
      get    "me",  to: "users#show"
      patch  "me",  to: "users#update"

      # Catalog
      resources :categories, only: [:index]
      resources :products,   only: [:index, :show]

      # Orders
      resources :orders, only: [:index, :show, :create]

      # Favorites — uses product_id as the :id param for DELETE
      resources :favorites, only: [:index, :create, :destroy]
    end
  end
end
