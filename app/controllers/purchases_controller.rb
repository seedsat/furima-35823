class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :find_item, only: [:index, :create]
  before_action :move_index, only: [:index]

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      purchase_pay(purchase_params[:token])
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def find_item
    @item = Item.find(params[:item_id])
  end

  def purchase_pay(token)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: token,
      currency: 'jpy'
    )
  end

  def purchase_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :house_number,
                   :building_name, :telephone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def move_index
    redirect_to root_path if @item.user.id == current_user.id
  end
end
