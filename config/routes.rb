SharpLink::Application.routes.draw do

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
  
  namespace :user, path: 'space' do
    resources :settings 
    resources :users do 
      resources :bookmarks
      resources :likes
      resources :posts
      resources :comments
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
  end

  resources :posts do 
    resources :assets
    resources :topics
  end
  resources :comments
  resources :categories
  resources :sections
  
  resources :schools

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
      resources :tags do
        resources :posts
      end   

      resources :posts

      resources :lessons

      resources :messages do
        collection do 
          get :draft
          get :sendout
        end
        member do
          post :reply
        end
      end
      resources :members do
        collection do 
          get :admin
        end
        member do 
          get :agree
          get :reject
          get :change_role
          get :set_admin
          get :new_message
          post :create_message
        end
      end

      resources :courses do
        resources :assignments
        resources :media do
          get :admin, on: :collection
        end
        resources :posts
        collection do 
          get :admin
        end
      end

      resources :slots do
        collection do 
          get :admin
        end
      end

      resources :settings do
        get :admin, on: :collection
      end

      resources :posts

      resources :media

      resources :albums do
        resources :images
        get :admin, on: :collection
      end

      resources :sections do
        get :admin, on: :collection
      end
      resources :assignments

      resources :exams do
        resources :reports
      end

    end
  end

  resources :users do
    member do
      get :follow
      get :unfollow
    end 
  end
  resources :webclasses do
    member do 
      get :admin
      get :apply
      get :logout
    end
  end
  resources :comments
  resources :shares
  resources :media
  resources :images
  
  root :to => 'home#index'
end
