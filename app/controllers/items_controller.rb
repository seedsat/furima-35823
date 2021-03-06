class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :move_index, only: [:edit, :update, :destroy]
  before_action :sold_out_move_index, only: [:edit, :update, :destroy]
  before_action :search_items, only: [:index, :search, :show]

  def index
    @items = Item.includes(:user).order('created_at desc').page(params[:page]).per(10)
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
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    end
  end

  def search
    @results = @i.result.includes(:user).page(params[:page]).per(8)
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :info, :category_id, :prefecture_id,
                                 :shippingday_id, :price, :itemstatus_id, :deliverycharge_id).merge(user_id: current_user.id)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def move_index
    redirect_to root_path unless @item.user.id == current_user.id
  end

  def sold_out_move_index
    if @item.purchase.present?
      redirect_to root_path
    end
  end

  def search_items
    if params[:q].present? && params[:q][:category_id_eq] == "1"
      params[:q][:category_id_eq] = ""
      @i = Item.ransack(params[:q])
    else
      @i = Item.ransack(params[:q])
    end
  end
end
