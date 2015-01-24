class StaticPagesController < ApplicationController

  def home
    @card = Card.actual if @card.nil?
    @translated_text = params[:translated_text]
    if @translated_text
      if ( @card[:translated_text] == @translated_text )
        flash[:success] = "Правильно"
        @card[:review_date] = Time.now + 3.days
        @card.save
      else
        flash[:fail] = "Не правильно"
      end
      redirect_to controller: 'static_pages', action: 'home'
    end
  end

end
