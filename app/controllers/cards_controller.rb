class CardsController < ApplicationController
  before_action :find_pack, except: [:review_card]
  before_action :find_card, only: [:edit, :show, :update, :destroy]

  def index
    @cards = @pack.cards
  end

  def show
  end

  def new
    @card = @pack.cards.new
  end

  def create
    @card = @pack.cards.build(card_params)
    if @card.save
      flash[:success] = "Карта успешно создана"
      redirect_to [@pack, @card]
    else
      render :new
    end
  end

  def update
    if @card.update_attributes(card_params)
      flash[:success] = "Карта обновлена"
      redirect_to [@pack, @card]
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @card.destroy
    flash[:success] = "Карта удалена"
    redirect_to pack_cards_path
  end

  def review_card
    get_card
    if @card.correct_answer(params[:translated_text], params[:answer_time])
      flash.now[:success] = "Правильно"
    else
      flash.now[:fail] = "Не правильно"
    end
    get_card_for_review
    respond_to do |format|
      format.js
    end
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image)
  end

  def get_card
    @card = current_user.cards.find(params[:card_id])
  end

  def get_card_for_review
    @card = current_user.card_for_review
  end

  def find_pack
    @pack = current_user.packs.find(params[:pack_id])
  end

  def find_card
    @card = @pack.cards.find(params[:id])
  end
end
