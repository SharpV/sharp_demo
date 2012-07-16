class SubjectsController < ApplicationController
  def ajax
    @subjects = Subject.find_by_grade_id params[:grade_id]
    render :partial => "subjects_list"
  end
end
