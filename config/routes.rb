SharpLink::Application.routes.draw do

  #devise_for :admin_users, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)

  devise_for :users, :controllers => {:registrations => "registrations", :passwords => "passwords", :sessions => "sessions", :omniauth_callbacks => 'omniauth_callbacks'}
  #ActiveAdmin.routes(self)
  match "errors/routing", :to => "errors#routing"

  match "/ajax/get_subjects_by_grade", :to => "ajax#get_subjects_by_grade"
  match "/ajax/get_cities_by_province", :to => "ajax#get_cities_by_province"
  match "/ajax/get_zones_by_city", :to => "ajax#get_zones_by_city"
  match "/ajax/get_schools_by_zone", :to => "ajax#get_schools_by_zone"
                                 
  resources :products do
    member do
      get :detail
    end
  end
  
  root :to => 'home#index'
end
