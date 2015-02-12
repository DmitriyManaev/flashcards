class CardsController < ApplicationController
  before_action :find_pack
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

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image)
  end

  def find_pack
    @pack = current_user.packs.find(params[:pack_id])
  end

  def find_card
    @card = @pack.cards.find(params[:id])
  end
end
