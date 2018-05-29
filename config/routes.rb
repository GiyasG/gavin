Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  # match '*unmatched_route', :to => 'application#raise_not_found!', :via => :all

  match 'photos' => "photos#index", :as => :photos_index, :via => [:get]
  match 'photos/new' => "photos#new", :as => :photos_new, :via => [:get]
  match 'photos/new' => "photos#create_photo_standalone", :as => :photos_teams, :via => [:post]
  match 'photos/:id' => "photos#show", :as => :photos_show, :via => [:get]
  match 'photos/:id/edit' => "photos#edit", :as => :photos_edit, via: [:get]
  match 'photos/:id/edit' => "photos#update", :as => :photos_update, via: [:put, :patch]
  match 'photos/:id/delete' => "photos#destroy_standalone", :as => :photos_destroy_standalone, via: [:get, :delete]

  get 'teams/view' => "teams#view", :as => :view_teams

  match 'teams/:id/contact_new' => "team_contacts#new", :as => :contactnew_teams, :via => [:get]
  match 'teams/:id/contact_new' => "team_contacts#create", :as => :contactcreate_teams, :via => [:post]
  match 'teams/:id/contact/:contact_id/edit' => "team_contacts#edit", :as => :contactedit_teams, via: [:get]
  match 'teams/:id/contact/:contact_id/edit' => "team_contacts#update", :as => :contactupdate_teams, via: [:put, :patch]
  match 'teams/:id/contact/:contact_id' => "team_contacts#contactdelete", :as => :contact_teams, via: [:delete]

  root to: "authorities#index"
  match 'show_authority/:authority_id' => 'photos#show_authority', as: :show_authority, via: [:get]
  match 'show_project/:project_id' => 'photos#show_project', as: :show_project, via: [:get]
  match 'show_paper/:paper_id' => 'photos#show_paper', as: :show_paper, via: [:get]
  match 'show_team/:team_id' => 'photos#show_team', as: :show_team, via: [:get]

  match 'next_project/:page' => 'authorities#aproject', as: :next_project, format: "js", via: [:get]
  match 'next_paper/:page' => 'authorities#apaper', as: :next_paper, format: "js", via: [:get]


  get '/search' => "search#index", :as => :search

  resources :authorities do
    resources :photos
    resources :projects do
      match 'pteams/:id' => 'projects#add_delete_team', as: :pteams, via: [:delete]
    end
    resources :papers do
      match 'pteams/:id' => 'papers#add_delete_team', as: :pteams, via: [:delete]
    end
    resources :contacts
    # do
    #   match 'pteams/:id' => 'projects#add_delete_team', as: :pteams, via: [:delete]
    # end
  end
  resources :teams

  resources :sessions, only: [:new, :create, :destroy]
  get "/editor" => "sessions#new", as: "editor"
  get "/logout" => "sessions#destroy", as: "logout"

  get '*unmatched_route', :to => 'application#raise_not_found!'

end
