class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_index, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order('created_at desc')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :info, :category_id, :itemstatus_id, :deliverycharge_id, :prefecture_id,
                                 :shippingday_id, :price).merge(user_id: current_user.id)
  end

  def move_index
    @item = Item.find(params[:id])
    redirect_to root_path unless user_signed_in? && @item.user.id == current_user.id
  end
end
