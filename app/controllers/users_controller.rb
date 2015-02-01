class UsersController < ApplicationController
  skip_before_action :require_login, only: [ :index, :new, :create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Регистрация прошла успешно"
      auto_login(@user)
      redirect_to root_path
    else
      flash.now[:fail] = "Неправильное имя или пароль"
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
