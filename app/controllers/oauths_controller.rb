class OauthsController < ApplicationController
  skip_before_action :require_login, only: [ :oauth, :callback, :destroy ]

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      flash[:notice] = "Авторизован через #{provider.titleize}"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        flash[:notice] = "Авторизован через #{provider.titleize}!"
      rescue
        flash[:notice] = "Неудачная авторизация через #{provider.titleize}!"
      end
    end
    redirect_to root_path
  end

  def destroy
    authentication = current_user.authentications.find_by_provider(auth_params)
    if authentication.present?
      authentication.destroy
      flash[:notice] = "Вы успешно вышли из #{provider.titleize} аккаунта."
    else
      flash[:notice] = "Вы не авторизованы через #{provider.titleize} аккаунт."
    end
    redirect_to root_path
  end
end
