class WebclassesController < ApplicationController
  respond_to :html, :js
  set_tab :index, :webclass_nav, only: [:show]
  def index
  end

  def show
    @current_webclass = Webclass.find params[:id]
    @apply_members = @current_webclass.members.apply
    if current_user
      @current_webclass_member = current_user.member(@current_webclass)
    else
      @current_webclass_member = nil
    end
    @sections = @current_webclass.current_term.sections.order(:start_at)

    render layout: 'webclass'
  end
end
