class PacksController < ApplicationController
  before_action :find_pack, only: [:edit, :show, :update, :destroy]
  before_action :get_current_pack_numb, only: [:index, :show]

  def index
    @packs = current_user.packs.all
  end

  def show
  end

  def new
    @pack = current_user.packs.new
  end

  def create
    @pack = current_user.packs.build(pack_params)
    if @pack.save
      flash[:success] = "Колода успешно создана"
      redirect_to @pack
    else
      render :new
    end
  end

  def update
    if @pack.update_attributes(pack_params)
      flash[:success] = "Колода обновлена"
      redirect_to @pack
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @pack.destroy
    flash[:success] = "Колода удалена"
    redirect_to packs_url
  end

  def set_current_pack
    session[:pack_id] = params[:pack_id]
    respond_to do |format|
      format.js
    end
  end

  private
    def pack_params
      params.require(:pack).permit(:title, :image)
    end

    def find_pack
      @pack = current_user.packs.find(params[:id])
    end

    def get_current_pack_numb
      @current_pack = session[:pack_id]
    end
end
