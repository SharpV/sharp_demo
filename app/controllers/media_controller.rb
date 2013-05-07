class MediaController < ApplicationController

  respond_to :html, :js

  set_tab :media, :site_nav

  def index
    if params[:column_id]
      @media = Medium.share.includes(:creator, :column).where(column_id: params[:column_id]).order('downloads_count desc').page params[:page]
    else
      @media = Medium.share.includes(:creator, :column).order('downloads_count desc').page params[:page]
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
