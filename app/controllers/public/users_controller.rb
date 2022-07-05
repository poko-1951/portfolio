class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update]

  def show
    @topics = Topic.where(user_id: @user.id)
  end

  def edit
  end

  def update
    @user.update(params_user)
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def params_user
    params.require(:user).permit(:name, :profile_image)
  end

end
