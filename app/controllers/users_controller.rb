class UsersController < ApplicationController
  before_action :users_item, only: :show
  before_action :move_index_user_nil, only: :show
  before_action :move_index, only: :show

  def show
  end

  private

  def users_item
    @user = User.find_by_id(params[:id])
  end

  def move_index
    redirect_to root_path unless current_user.id == @user.id
  end

  def move_index_user_nil
    redirect_to root_path if @user.nil?
  end
end
