SharpLink::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => {:registrations => "registrations", :passwords => "passwords", :sessions => "sessions", :omniauth_callbacks => 'omniauth_callbacks'}
  
  match "/my", :to => "home#index"                                    
  match '/new/:type', :to => 'my/posts#new', :as => :new_post
  match '/categories/:parent_id/new', :to => 'my/post_categories#new', :as => :add_post_category
  match "errors/routing", :to => "errors#routing"
  match "tags/:tag/posts",  :to => "posts#show",:as => "tag_posts"
  match "/ajax/get_subjects_by_grade/:grade_id", :to => "ajax#get_subjects_by_grade"
  match "/ajax/get_cities_by_province/:province_code", :to => "ajax#get_cities_by_province"

  match "/admin", :to => "admin#index"                                     
  namespace :admin do
    resources :comments

    resource :session

    resources :posts, :pages do
      post 'preview', :on => :collection
    end

    root :to => 'dashboard#show'
  end
  
  match "me" => "me#index"
  namespace :me do
    resources :posts
    resources :comments
    resources :settings
    resources :courses
    resources :school_classes
    resources :groups
    resources :likes
    resources :notifications
  end
  resources :topics
  resources :posts
  resources :comments
  resources :categories
  resources :sections
  resources :assets
  resources :teams
  resources :schools

  resources :users do 
    resources :activities
    resources :posts
    resources :groups
    resources :questions
    resources :settings
    resources :comments
    resources :passwords
    resources :likes
    resources :profiles
    resources :courses
    resources :notifications
  end

  resources :courses do
    resources :slots 
    resources :sections
  end

  resources :groups do
    resources :topics
    resources :members
  end
  resources :pages do      
    resources :comments
  end
  delete 'likes/:resource_name/:resource_id' => "my/likes#destroy", :as => 'like'
  post 'likes/:resource_name/:resource_id' => "my/likes#create",  :as => 'like'

  resources :grades do
    resources :subjects do
      collection do
        get :hot
        get :recommand
      end
    end
  end

  resources :pages

  resources :tags, :only => [:index] do
    get :subscribe, :on => :member
  end
  resources :profiles
  
  root :to => 'home#index'
end
