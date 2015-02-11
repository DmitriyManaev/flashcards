class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:home]

  def home
    if current_user
      if current_user.current_pack
        @card = current_user.current_pack.cards.actual.random.first
      else
        @card = current_user.cards.random.first
      end
    end
  end

  def check_card
    @card = current_user.cards.find(params[:card_id])
    if @card.correct_answer(params[:translated_text])
      flash[:success] = "Правильно"
    else
      flash[:fail] = "Не правильно"
    end
    redirect_to root_path
  end
end
