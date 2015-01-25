class StaticPagesController < ApplicationController

  def home
    @card = Card.actual.first
  end

  def check_card
    @card = Card.find(params[:card_id])
    if @card && params[:translated_text]
      if @card.correct_answer(params[:translated_text])
        flash[:success] = "Правильно"
      else
        flash[:fail] = "Не правильно"
      end
    end
    redirect_to :root
  end
end
