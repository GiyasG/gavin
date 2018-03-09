Rails.application.routes.draw do

  get 'teams/view' => "teams#view", :as => :view_teams

  root to: "authorities#index"
  match 'show_project/:project_id' => 'photos#show_project', as: :show_project, via: [:get]
  match 'show_paper/:paper_id' => 'photos#show_paper', as: :show_paper, via: [:get]
  match 'show_team/:team_id' => 'photos#show_team', as: :show_team, via: [:get]
  resources :authorities do
    resources :photos
    resources :projects
    resources :papers
    resources :contacts
    # do
    #   match 'pteams/:id' => 'projects#add_delete_team', as: :pteams, via: [:delete]
    # end
  end
  resources :teams
end
