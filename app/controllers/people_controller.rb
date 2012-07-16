class PeopleController < ApplicationController
  before_filter :find_person
  set_tab :home
  set_tab :documents, :person, :only => %w(documents)
  set_tab :groups, :person, :only => %w(groups)
  set_tab :slots, :person, :only => %w(slots)
  set_tab :posts, :person, :only => %w(posts)
  set_tab :feeds, :person, :only => %w(feeds, show)
  set_tab :events, :person, :only => %w(events)
  set_tab :settings, :person, :only => %w(settings)
  
  def index
  end
  
  def show
    @person = User.find params[:id]
  end
  
  def me
  end
  
  def edit
    @user = current_user
  end
  
  def settings
  end
  
  def feeds
  end
  
  def documents
  end
  
  def posts
  end
  
  def groups
  end
  
  def slots
  end
  
  def events
  end
  
  private
  def find_person
    @person = User.find params[:id]
  end
end
