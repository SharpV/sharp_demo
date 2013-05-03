class ApplicationController < ActionController::Base
      
  protect_from_forgery
  after_filter :set_content_type, :set_current_context

  protected

  def set_content_type
    headers['Content-Type'] ||= 'text/html; charset=utf-8'
  end
  
  def set_current_context
    @current_namespace = nil
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end
end
