class AjaxController < ApplicationController
  def get_subjects_by_grade
    if params[:grade_id]
      @subjects = Subject.find_all_by_grade_id params[:grade_id]
    else
      @subjects = Subject.all
    end
    render :partial => "subject_list"
  end

  def get_cities_by_province
    @cities = City.find_all_by_province_code params[:province_code]
    render :partial => "city_list"
  end
end
