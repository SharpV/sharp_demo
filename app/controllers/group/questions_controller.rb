class Group::QuestionsController < GroupController
  before_filter :set_group_tab
  set_tab :question, :group_menus
  set_tab :question, :group_actions, :only => %w(new edit)
  
  
  def index
    @questions = Group::Question.all
  end
  
  
  def show
    @question = Group::Question.find(params[:id])
  end


  def new
    @question = Group::Qustion.new
  end
  
  def edit
    @question = Group::Question.find(params[:id])
  end

  def create
    @question = current_user.questions.build params[:group_question]
    if @question.save
      redirect_to group_question_path(@current_group, @question)
    else
      render :action => :new
    end
  end


  def update
    @question = Group::Question.find(params[:id])
    if @Group::Question.update_attributes(params[:forum_topic])
      redirect_to group_question_path(@current_group, @question)
    else
      render :action => :edit
    end
  end


  def destroy
    @question = Group::Question.find(params[:id])
    @question.destroy
  end
end

