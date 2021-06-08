class UsersController < ApplicationController
  before_action :users_item, only: :show
  before_action :move_index, only: :show

  def show
  end

  private

  def users_item
    @user = User.find(params[:id]);
  end

  def move_index
    redirect_to root_path unless current_user.id == @user.id
  end
end
