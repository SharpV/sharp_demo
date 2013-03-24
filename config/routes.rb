SharpLink::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => {:registrations => "registrations", :passwords => "passwords", :sessions => "sessions", :omniauth_callbacks => 'omniauth_callbacks'}
  match "errors/routing", :to => "errors#routing"
  match "tags/:tag/posts",  :to => "posts#show",:as => "tag_posts"
  match "/ajax/get_subjects_by_grade/:grade_id", :to => "ajax#get_subjects_by_grade"
  match "/ajax/get_cities_by_province/:province_code", :to => "ajax#get_cities_by_province"

  match "/admin", :to => "admin#index"    
                                 
  namespace :admin do
    resources :comments

    resource :session

    root :to => 'dashboard#show'
  end
  
  match "me" => "me#index"

  namespace :me do
    resources :links
    resources :likes
    resources :posts
    resources :comments
    resources :settings 
    resources :certifications
    resources :photos
    resources :courses do
      collection do
        get :manage
        post :rebuild
      end
    end
    resources :school_classes
    resources :groups
    resources :notes
    resources :passwords
    resources :notifications
    resources :activities
    resources :media
    resources :collections
    resources :folders do
      collection do
        get :manage
        post :rebuild
      end
    end
    resources :assets
    resources :audios do 
      resources :assets
    end
    resources :post_categories do
      collection do
        get :manage
        post :rebuild
      end
    end
  end

  resources :posts do 
    resources :assets
    resources :topics
  end
  resources :comments
  resources :categories
  resources :sections
  
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
    resources :questions 
    resources :comments
  end

  resources :groups do
    get :apply, on: :member
    post :email_members, on: :member
    get :admin, on: :member
  end

  namespace :group  do
    resources :groups do
      resources :topics
      resources :media
      resources :members
    end
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

  resources :tags, :only => [:index] do
    get :subscribe, :on => :member
  end

  resources :pages

  namespace :course do
    resources :slots do
      resources :course_discusses
    end

    resources :courses do
      resources :courses_members, as: :members, path: :members do

      end
      
      resources :sections do
        collection do 
          get :admin
        end
        resources :slots 
      end

      resources :course_categories do
        resources :course_discusses
      end   

      resources :course_discusses, as: :discusses, path: :discusses

      member do 
        get :admin
        get :apply
      end
    end
  end

  resources :profiles
  
  root :to => 'home#index'
end
