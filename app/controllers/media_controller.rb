class MediaController < ApplicationController

  respond_to :html, :js

  set_tab :media, :site_nav

  def index
    if params[:grade_id]
      @media = Medium.share.includes(:creator).where(grade_id: params[:grade_id]).page params[:page]
    elsif params[:subject_id]
      @media = Medium.share.includes(:creator).where(subject_id: params[:subject_id]).page params[:page]
    else
      @media = Medium.share.includes(:creator).page params[:page]
    end
  end

  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy
  end
end
