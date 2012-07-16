module QuestionsHelper
  
  def facet(name, results)
    render :partial => "facet", :locals => {:facet => name, :results => results }
  end
  
end