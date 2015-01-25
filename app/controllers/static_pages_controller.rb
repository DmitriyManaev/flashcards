class StaticPagesController < ApplicationController

  def home
    params[:card_id] ? @card = Card.find(params[:card_id]) : @card = Card.actual.random.first
    check_card if params[:translated_text]
  end

  private
    def check_card
      @card.correct_answer(params[:translated_text]) ? flash[:success] = "Правильно" : flash[:fail] = "Не правильно"
      redirect_to :root
    end
end
