class UsersController < ApplicationController
  set_tab :home, :site_menus

  include SocialStream::Controllers::Subjects

  load_and_authorize_resource
  
  before_filter :find_user

  respond_to :html, :xml, :js

  def index
    @users = User.alphabetic.
    letter(params[:letter]).
    name_search(params[:search]).
    tagged_with(params[:tag]).
    page(params[:page]).per(10)
  end

  # Supported through devise
  def show
    @user = current_user 
  end
  # Not supported yet
  def destroy; end

  protected

  # Overwrite resource method to support slug
  # See InheritedResources::BaseHelpers#resource
  def resource
    @user ||= end_of_association_chain.find_by_slug!(params[:id])
  end
  
  def find_user
    unless params[:user_id] and (@user = User.find_by_login params[:user_id])
      @user = current_user 
    end
  end

end
