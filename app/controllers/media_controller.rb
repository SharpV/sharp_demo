class MediaController < ApplicationController

  respond_to :html, :js

  set_tab :media, :site_nav

  def index
    if params[:grade_id]
      @media = Medium.share.includes(:creator).where(grade_id: params[:grade_id]).order('downloads_count desc').page params[:page]
    elsif params[:subject_id]
      @media = Medium.share.includes(:creator).where(subject_id: params[:subject_id]).order('downloads_count desc').page params[:page]
    else
      @media = Medium.share.includes(:creator).order('downloads_count desc').page params[:page]
    end
    @top_users = Medium.top_users
    set_tab :index, :media_nav
  end

  def hot
    @media = Medium.share.includes(:creator).order('readings_count desc').page params[:page]
    set_tab :hot, :media_nav  
    @top_users = Medium.top_users
    render 'media/index'
  end

  def latest
    @media = Medium.share.includes(:creator).order('created_at desc').page params[:page]
    set_tab :latest, :media_nav  
    @top_users = Medium.top_users
    render 'media/index'
  end

  def top

  end

  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy
  end
end
