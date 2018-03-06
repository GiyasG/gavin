Rails.application.routes.draw do
  root to: "authorities#index"
  resources :authorities do
    resources :photos
    resources :projects
    # do
    #   match 'pteams/:id' => 'projects#add_delete_team', as: :pteams, via: [:delete]
    # end

  end

end
