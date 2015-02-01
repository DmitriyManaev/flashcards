class ApplicationController < ActionController::Base
  before_action :require_login
  protect_from_forgery with: :exception
  private
    def not_authenticated
      flash[:notice] = "Авторизуйтесь"
      redirect_to login_path
    end
end
