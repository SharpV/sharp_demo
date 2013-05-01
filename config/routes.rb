SharpLink::Application.routes.draw do

  #devise_for :admin_users, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)

  devise_for :users, :controllers => {:registrations => "registrations", :passwords => "passwords", :sessions => "sessions", :omniauth_callbacks => 'omniauth_callbacks'}
  #ActiveAdmin.routes(self)
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
    resources :users do 
      resources :settings 
      resources :albums do
        resources :images
      end
      resources :images
      resources :likes
      resources :posts
      resources :comments
      resources :messages do
        collection do 
          get :draft
          get :sendout
        end
        member do
          post :reply
        end
      end
      resources :certifications
      resources :groups
      resources :followings do
        get :activities, on: :collection
      end

      resources :followers
      resources :webclasses
      resources :questions
      resources :answers
      resources :passwords
      resources :notifications
      resources :activities
      resources :media
      resources :webclasses
      resources :folders do
        collection do
          get :admin
        end
        resources :media
      end
  
      resources :categories do
        resources :posts
      end

      member do
        get :follow
        get :unfollow
      end
    end
  end


  namespace :group do
    resources :groups do
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

      resources :folders do
        resources :media
      end

      resources :media

      resources :albums do
        resources :images
      end

      resources :images

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
  resources :groups do
    member do 
      get :admin
      get :apply
      get :logout
    end
  end


  resources :comments
  resources :webclasses
  
  resources :schools
  resources :pages 
  
  resources :tags, :only => [:index] do
    get :subscribe, :on => :member
  end

  resources :pages
  resources :questions do
    resources :answers
  end
  resources :answers

  resources :posts
  resources :grades do
    resources :subjects
  end

  resources :subjects do
    resources :posts
    resources :media
    resources :questions
  end
  resources :grades do
    resources :posts
    resources :media
    resources :questions
  end
  resources :media
  resources :images
  
  root :to => 'home#index'
end
