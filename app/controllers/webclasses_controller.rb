class WebclassesController < ApplicationController

  set_tab :webclasses, :site_nav

  def index
    @webclasses = Group.webclass.includes(:school).order('members_count desc, readings_count desc').page params[:page]
    @hot_webclasses = Group.hot_webclasses
    set_tab :index, :webclasses_nav
  end
  
  
  # Lists the requested friends of the specified user
  def hot
    @webclasses = Group.webclass.includes(:school).order('readings_count desc').page params[:page]
    @hot_webclasses = Group.hot_webclasses
    set_tab :hot, :webclasses_nav
    render template: 'webclasses/index'
  end
  
  
  # Lists the pending friends of the specified user
  def latest
    @webclasses = Group.webclass.includes(:school).order('created_at desc').page params[:page]
    @hot_webclasses = Group.hot_webclasses
    set_tab :latest, :webclasses_nav
    render template: 'webclasses/index'
  end
  
  
  def top
    redirect_to user_path(params[:id])
  end
  
  
  # Create a new friendship request
  def create
    @user = User.find(current_user)
    @friend = User.find(params[:friend_id])  
    respond_to do |format|
      format.html { 
        if Friendship.request(@user, @friend)
          redirect_to user_path(@friend)
        else
          redirect_to user_path(current_user)
        end
      }
      format.xml { 
        if Friendship.request(@user, @friend)
          render :xml => @friend, :status => :created 
        else
           render :xml => {:error=>'Could not create request'}, :status => :unprocessable_entity
        end
      }
      format.json { 
        if Friendship.request(@user, @friend)
          render :json => @friend.to_json, :status => :created 
        else
          render :json => {:error=>'Could not create request'}.to_json, :status => :unprocessable_entity
        end
      }
    end

  end
  
  
  def update 
    @user = User.find(current_user)
    @friend = User.find(params[:id])
    if Friendship.accept(@user, @friend)
      respond_to do |format|
        format.html { 
          flash[:notice] = 'Friend sucessfully accepted!'
          redirect_to user_friends_path(current_user)
         }
         format.xml { render :xml => @friend, :status => :created }
         format.json { render :json => @friend.to_json, :status => :created }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.xml  { render :xml => {:error=>'unable to save'}, :status => :unprocessable_entity }
        format.json { render :json => {:error=>'unable to save'}.to_json, :status => :unprocessable_entity }
      end
    end
  end
  
  
  def destroy
    @user = User.find(params[:user_id])
    @friend = User.find(params[:id])
    Friendship.breakup(@user, @friend)
    redirect_to user_path(@user)
  end
  
end
