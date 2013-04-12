class WebclassesController < ApplicationController

  def index
  end

  def show
    @current_webclass = Webclass.find params[:id]
    if current_user
      @current_webclass_member = current_user.member(@current_webclass)
    else
      @current_webclass_member = nil
    end
    render layout: 'webclass'
  end
end
