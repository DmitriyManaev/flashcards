class ReviewsController < ApplicationController
  def create
    card = current_user.cards.find(card_id)
    if card.correct_answer(params[:translated_text], params[:answer_time])
      flash.now[:success] = "Правильно"
    else
      flash.now[:fail] = "Не правильно"
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def card_id
    params.require(:card_id)
  end
end
