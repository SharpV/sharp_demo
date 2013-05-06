class SchoolsController < ApplicationController

  respond_to :html, :js

  set_tab :schools, :site_nav

  def index
    if params[:province_id]
      @schools = School.where(province_id: params[:province_id]).order('groups_count desc, readings_count desc').page(params[:page])
    elsif params[:city_id]
      @schools = School.where(city_id: params[:city_id]).order('groups_count desc, readings_count desc').page(params[:page])
    elsif params[:zone_id]
      @schools = School.where(zone_id: params[:province_id]).order('groups_count desc, readings_count desc').page(params[:page])
    else
      @schools = School.order('groups_count desc, readings_count desc').page(params[:page])
    end
    @hot_schools = School.order('readings_count desc').limit(10)
    @latest_schools = School.order('created desc').limit(10)
  end

end
