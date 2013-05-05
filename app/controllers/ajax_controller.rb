class AjaxController < ApplicationController

  respond_to :js, :html

  def get_subjects_by_grade
    if params[:grade_id]
      @subjects = Subject.find_all_by_grade_id params[:grade_id]
    else
      @subjects = Subject.all
    end
    render :partial => "subject_list"
  end

  def get_cities_by_province
    @cities = City.where province_id: params[:province_id]
  end

  def get_zones_by_city
    @zones = Zone.where city_id: params[:city_id]
  end

  def get_schools_by_zone
    @schools = School.where zone_id: params[:zone_id]
  end
end
