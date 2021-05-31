class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :find_item, only: [:index, :create]

  def index
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(user_id: current_user.id, item_id: params[:item_id])
    @token = params[:token]
    unless  @token.nil?
      purchase_pay
      @purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def find_item
    @item = Item.find(params[:item_id])
  end

  def purchase_pay
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: @token,
      currency: 'jpy'
    )
  end
end
