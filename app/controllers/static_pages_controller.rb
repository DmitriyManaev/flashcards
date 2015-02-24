class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:home]

  def home
    get_card if current_user
  end

  def check_card
    @card = current_user.cards.find(params[:card_id])
    if @card.correct_answer(params[:translated_text], params[:answer_time])
      flash.now[:success] = "Правильно"
    else
      flash.now[:fail] = "Не правильно"
    end
    get_card
    respond_to do |format|
      format.js
    end
  end

  private

  def get_card
    if current_user.current_pack
      @card = current_user.current_pack.cards.actual.first
    else
      @card = current_user.cards.actual.first
    end
  end
end
