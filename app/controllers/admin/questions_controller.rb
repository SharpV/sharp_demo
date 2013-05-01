class Me::QuestionsController < MeController

  set_tab 'questions', :me_nav
  set_tab 'index', :question_nav

  def index
    @questions = current_user.questions.page params[:page]

  end

  # GET /me/notes/1
  # GET /me/notes/1.json
  def show
    @post = Post::Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /me/notes/new
  # GET /me/notes/new.json
  def new
    @post = Post::Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /me/notes/1/edit
  def edit
    @me_note = Me::Note.find(params[:id])
  end

  # POST /me/notes
  # POST /me/notes.json
  def create
    @post = Post::Note.new(params[:post_note])
    @post.postable = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to me_note_path(@post), notice: 'Note was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /me/notes/1
  # PUT /me/notes/1.json
  def update
    @post = Post::Note.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post_note])
        format.html { redirect_to @post, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /me/notes/1
  # DELETE /me/notes/1.json
  def destroy
    @post = Post::Note.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to me_notes_url }
      format.json { head :no_content }
    end
  end
end