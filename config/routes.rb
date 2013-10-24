SampleDemo::Application.routes.draw do

  resources :articles do as_routes end

  resources :employees

  resources :products

  resources :pictures

  resources :users do
    collection do
      get :load_services
      get :remote
    end
  end

  resources :mail do
    collection do
      get :ssss
    end
  end
    resources :login do
    collection do
      get :login
      get :load_login_page
      post :uploadFile_mail_to_patient
    end
  end
  root :to => "users#index"
  # root :to => 'maill#ssss'
  # match 'logout', :to => 'maill#ssss', :as => "logout"
  # map.logout '/logout', :controller => 'maill', :action => 'ssss'
#map.root :controller => "maill", :action => "ssss", :id => 3
  # match ':controller(/:action(/:id(.:format)))', :controller => /bloodbank\/[^\/]+/
  # match ':controller(/:action(/:id(.:format)))', :controller => /billing_admin\/[^\/]+/
  # match ':controller(/:action(/:id(.:format)))', :controller => /finance\/[^\/]+/
  # match ':controller(/:action(/:id(.:format)))'
end
