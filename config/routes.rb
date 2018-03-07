Rails.application.routes.draw do
  root to: "authorities#index"
  match 'show_project/:project_id' => 'photos#show_project', as: :show_project, via: [:get]
  match 'show_paper/:paper_id' => 'photos#show_paper', as: :show_paper, via: [:get]
  resources :authorities do
    resources :photos
    resources :projects
    resources :papers

    # do
    #   match 'pteams/:id' => 'projects#add_delete_team', as: :pteams, via: [:delete]
    # end

  end

end
