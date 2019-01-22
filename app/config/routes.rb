Rails.application.routes.draw do
  resources :messages, only: [:create, :show]
  get "/health_check" => "health_check#index"
end
