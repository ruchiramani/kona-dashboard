# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope '/api' do
    # resources :org
    get '/org/:id/weekly_overview', to: 'org#weekly_overview'
    get '/org/:id/weekly_breakdown', to: 'org#weekly_breakdown'
    get '/org/:id/green_team', to: 'org#green_team'
    get '/org/:id/red_team', to: 'org#red_team'
    get '/org/:id/top_emotions', to: 'org#top_emotions'
  end
end
