class User::QuestionsController < UserController

  before_filter :check_owner#, only: [:new, :create, :update, :destroy, :edit]

  set_tab :questions, :user_nav

  def index
    @questions = current_user.questions.includes(:user).order('created_at desc').page params[:page]
    @top_users = Question.top_users
    set_tab :my, :questions_nav
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = current_user.questions.build params[:question]
    if @question.save
      redirect_to @question
    else
      render action: :new
    end
  end

  def update
    @question = Question.find params [:id]
    if @question.update_attributes params[:question]
      redirect_to @question
    else
      render action: :edit
    end
  end

  def destroy
    @question = Question.find params [:id]
    @question.destroy
    redirect_to params[:return] || [user, current_user, :questions]
  end
end
