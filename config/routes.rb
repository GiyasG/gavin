Rails.application.routes.draw do
  root to: "authorities#index"
  resources :authorities do
    resources :photos
  end
end
