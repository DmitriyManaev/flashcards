class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:home]

  def home
    if current_user
      if @pack = current_pack
        @card = @pack.cards.actual.first
      end
    end
  end

  def check_card
    @pack = current_pack
    @card = @pack.cards.find(params[:card_id])
    if @card.correct_answer(params[:translated_text])
      flash[:success] = "Правильно"
    else
      flash[:fail] = "Не правильно"
    end
    redirect_to root_path
  end

  private
    def current_pack
      if session[:pack_id]
        current_user.packs.find(session[:pack_id])
      else
        current_user.packs.first
      end
    end
end
