Joomen2::Application.routes.draw do

  # E V E N T S
  match 'start', :to => 'events#create', :as => "start"
  match 'find/:id', :to  => 'events#show'  
  resources :events

  # I T E M S
  resources :items do
    collection do
      get :create
    end
  end
  resources :items

  # S T A T I C
  resources :static do
    collection do
      get :change_language
      get :about
      get :kontakt
      get :faq
      get :forbidden
      get :information
      get :start
      get :impressum
    end
  end

  # H I S T O R Y
  match 'log/:id', :to => 'histories#index'
  match 'rss/:id', :to => 'histories#rss', :format => "xml"
  
 
  root :to => 'static#index'

  match ':controller(/:action(/:id))(.:format)'
end
