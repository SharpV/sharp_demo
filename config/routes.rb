SharpLink::Application.routes.draw do

  #devise_for :admin_users, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)

  devise_for :users, :controllers => {:registrations => "registrations", :passwords => "passwords", :sessions => "sessions", :omniauth_callbacks => 'omniauth_callbacks'}
  #ActiveAdmin.routes(self)
  match "errors/routing", :to => "errors#routing"

  match "/ajax/get_subjects_by_grade/:grade_id", :to => "ajax#get_subjects_by_grade"
  match "/ajax/get_cities_by_province", :to => "ajax#get_cities_by_province"
  match "/ajax/get_zones_by_city", :to => "ajax#get_zones_by_city"
  match "/ajax/get_schools_by_zone", :to => "ajax#get_schools_by_zone"
                                 
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
      resources :groups
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
    collection do
      get :me
    end
  end
  resources :groups do
    member do 
      get :admin
      get :apply
      get :logout
    end
    collection do
      get :latest
      get :hot
      get :top
    end
  end


  resources :comments
  resources :webclasses do
    collection do
      get :latest
      get :hot
      get :top
    end
  end
  
  resources :schools do
    resources :webclasses
  end
  resources :pages 
  
  resources :tags, :only => [:index] do
    get :subscribe, :on => :member
  end

  resources :answers do
    collection do
      get :my
    end
  end

  resources :pages
  resources :questions do
    resources :answers
    collection do
      get :my
      get :top
      get :hot
      get :latest
    end
  end
  resources :answers

  resources :posts do
    collection do
      get :latest
      get :hot
      get :top
    end
  end
  resources :grades do
    resources :subjects
  end

  resources :subjects do
    resources :questions
  end
  resources :grades  do
    resources :questions
  end
  
  resources :columns do
    resources :posts
    resources :media
    resources :questions
  end
  resources :media do
    collection do
      get :latest
      get :hot
      get :top
    end
  end

  resources :provinces do
    resources :schools
  end
  resources :cities do
    resources :schools
  end
  resources :zones do
    resources :schools
  end
  resources :images
  
  root :to => 'home#index'
end
