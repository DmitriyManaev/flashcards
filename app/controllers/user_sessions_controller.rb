class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: :destroy

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember_me])
      flash[:success] = "Добро пожаловать"
      redirect_back_or_to root_path
    else
      flash.now[:fail] = "Ошибка, неверный логин или пароль"
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = "Вы успешно вышли из системы"
    redirect_to root_path
  end
end
