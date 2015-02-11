class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:home]

  def home
    if current_user && current_pack
      @card = current_pack.cards.actual.first
    end
  end

  def check_card
    @card = current_pack.cards.find(params[:card_id])
    if @card.correct_answer(params[:translated_text])
      flash[:success] = "Правильно"
    else
      flash[:fail] = "Не правильно"
    end
    redirect_to root_path
  end

  private

  def current_pack
    if current_user.current_pack
      current_user.current_pack
    else
      current_user.packs.first
    end
  end
end
