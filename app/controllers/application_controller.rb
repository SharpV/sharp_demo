class ApplicationController < ActionController::Base
  
  before_filter :authenticate_user!
  
  protect_from_forgery
  after_filter :set_content_type

  protected

  def set_content_type
    headers['Content-Type'] ||= 'text/html; charset=utf-8'
  end
  
  def set_current_user
    @user = current_user if current_user
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end
end
