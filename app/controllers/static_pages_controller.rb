class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:home]

  def home
    @card = current_user.card_for_review if current_user
    respond_to do |format|
      format.html
      format.js
    end
  end
end
