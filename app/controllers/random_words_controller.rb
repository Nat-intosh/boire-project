class RandomWordsController < ApplicationController
  before_action :set_random_word, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  # GET /random_words or /random_words.json
  def index
    @random_words = RandomWord.all
  end

  # GET /random_words/1 or /random_words/1.json
  def show
  end

  # GET /random_words/new
  def new
    @random_word = RandomWord.new
  end

  # GET /random_words/1/edit
  def edit
  end

  # POST /random_words or /random_words.json
  def create
    @random_word = RandomWord.new(random_word_params)

    respond_to do |format|
      if @random_word.save
        format.html { redirect_to random_word_url(@random_word), notice: "Random word was successfully created." }
        format.json { render :show, status: :created, location: @random_word }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @random_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /random_words/1 or /random_words/1.json
  def update
    respond_to do |format|
      if @random_word.update(random_word_params)
        format.html { redirect_to random_word_url(@random_word), notice: "Random word was successfully updated." }
        format.json { render :show, status: :ok, location: @random_word }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @random_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /random_words/1 or /random_words/1.json
  def destroy
    @random_word.destroy!

    respond_to do |format|
      format.html { redirect_to random_words_url, notice: "Random word was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_random_word
      @random_word = RandomWord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def random_word_params
      params.require(:random_word).permit(:word)
    end

    def require_admin
      unless current_user.admin?
        redirect_to root_path, alert: 'You are not authorized to perform this action.'
      end
    end
end
