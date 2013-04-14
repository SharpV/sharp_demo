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
    resources :bookmarks
    resources :likes
    resources :posts
    resources :comments
    resources :settings 
    resources :photos
    resources :certifications
    resources :groups
    resources :courses do
      collection do
        get :admin
      end
    end
    resources :webclasses
    resources :questions
    resources :answers
    resources :passwords
    resources :notifications
    resources :activities
    resources :media
    resources :collections
    resources :folders do
      collection do
        get :admin
      end
      resources :media
    end

    resources :categories do
      collection do
        get :admin
        post :rebuild
      end
      resources :posts
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
    get :admin, on: :member
  end

  resources :groups do
    get :apply, on: :member
    post :email_members, on: :member
    get :admin, on: :member
  end

  namespace :group  do
    resources :groups do
      resources :posts
      resources :media
      resources :members do
        get :admin, on: :collection
      end
      resources :settings do
        get :admin, on: :collection
      end
      resources :folders do
        resources :media
        get :admin, on: :collection
      end
      resources :categories do
        resources :posts
        get :admin, on: :collection
      end
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
  resources :questions do
    resources :answers
  end
  resources :answers

  namespace :webclass do

    resources :webclasses do

      resources :posts

      resources :lessons

      resources :members do
        collection do 
          get :admin
        end
      end

      resources :courses do
        collection do 
          get :admin
        end
      end

      resources :slots do
        collection do 
          get :admin
        end
      end

      resources :folders do
        collection do 
          get :admin
        end        
      end

      resources :categories do
        resources :posts
        collection do 
          get :admin
        end
      end   

      resources :settings do
        get :admin, on: :collection
      end

      resources :posts

      resources :media

      resources :sections do
        get :admin, on: :collection
      end

      resources :assignments

      resources :reports

      member do 
        get :admin
        get :apply
      end
    end
  end

  resources :users do
    member do
      get :follow
      get :unfollow
    end 
  end
  resources :webclasses

  resources :shares
  
  root :to => 'home#index'
end
