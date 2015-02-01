class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [ :home ]

  def home
    @card = current_user.cards.actual.first if current_user
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
