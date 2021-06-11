class LikesController < ApplicationController
  before_action :move_user_session, only: :create
  before_action :set_item

  def create
    Like.create(user_id: current_user.id, item_id: @item.id)
  end

  def destroy
    Like.find_by(user_id: current_user.id, item_id: @item.id).destroy
  end

  private

  def set_item
    @item =  Item.find(params[:id])
  end

  def move_user_session
    redirect_to new_user_session_path if current_user.nil?
  end
end
