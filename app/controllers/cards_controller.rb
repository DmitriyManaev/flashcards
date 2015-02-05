class CardsController < ApplicationController
  before_action :find_card, only: [:edit, :show, :update, :destroy]

  def index
    @cards = current_user.cards.all
  end

  def show
  end

  def new
    @card = current_user.cards.new
  end

  def create
    @card = current_user.cards.build(card_params)
    if @card.save
      flash[:success] = "Карта успешно создана"
      redirect_to @card
    else
      render :new
    end
  end

  def update
    if @card.update_attributes(card_params)
      flash[:success] = "Карта обновлена"
      redirect_to @card
    else
      render :edit
    end.id
  end

  def edit
  end

  def destroy
    @card.destroy
    flash[:success] = "Карта удалена"
    redirect_to cards_url
  end

  private
    def card_params
      params.require(:card).permit(:original_text, :translated_text, :image)
    end

    def find_card
      @card = current_user.cards.find(params[:id])
    end
end
