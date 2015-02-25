class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:home]
  before_action :set_card, only: [:home]

  def home
  end

  def check_card
    @card = current_user.cards.find(params[:card_id])
    if @card.correct_answer(params[:translated_text], params[:answer_time])
      flash.now[:success] = "Правильно"
    else
      flash.now[:fail] = "Не правильно"
    end
    set_card
    respond_to do |format|
      format.js
    end
  end

  def set_card
    @card = current_user.get_card if current_user
  end
end
