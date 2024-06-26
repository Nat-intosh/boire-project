class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :destroy, :import]
  before_action :require_admin, only: [:new, :create, :show, :edit, :update, :destroy, :import]
  # GET /cards or /cards.json
  def index
    @cards = Card.all
    @random_card = Card.order("RANDOM()").first
    @players = params[:players] || []
    @penalities =  (rand(2..5)).to_s
    @randomword = RandomWord.order("RANDOM()").first
    @rm = @randomword.word

  end

  def next_random_card
    # Fetch next random card logic
    @cards = Card.all
    @random_card = Card.order("RANDOM()").first
    @players = params[:players] || []
    @penalities = rand(2..5)

 

    respond_to do |format|
      format.js
    end

    # render :index # Render the index template with the next random card
  end
  # GET /cards/1 or /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards or /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to card_url(@card), notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to card_url(@card), notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy!

    respond_to do |format|
      format.html { redirect_to cards_url, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    return redirect_to request.referer, notice: 'No file added' if params[:file].nil?
    return redirect_to request.referer, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

    CsvImportService.new.call(params[:file])

    redirect_to request.referer, notice: 'Import started...'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:card_type, :title, :desc, :group)
    end

    def require_admin
      unless current_user.admin?
        redirect_to root_path, alert: 'You are not authorized to perform this action.'
      end
    end
end
