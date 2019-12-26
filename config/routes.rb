Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/api/v1' do
    resources :books do
      resources :reviews
    end
    resources :authors
    resources :clients do
      resources :reviews
    end
  end
end