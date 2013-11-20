AAdmin::Engine.routes.draw do
  get '/', :to => 'dashboard#index', :as => :dashboard
  get '/*all', :to => 'dashboard#index'

  devise_for :users, :skip => :all

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      devise_scope :user do

        post 'login' => 'sessions#create', :as => 'login'
        #IE8 cannot use Angulars $http.delete() call, at present to keep to post on named route.
        #delete 'sessions' => 'sessions#destroy', :as => 'session_logout'
        post 'logout' => 'sessions#destroy', :as => 'logout'

        get 'current_user' => 'users#show_current_user', :as => 'show_current_user'
      end
    end
  end
  # Add your extension routes here
end