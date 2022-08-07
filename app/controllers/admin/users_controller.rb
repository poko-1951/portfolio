class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :update]

  def index
    @users = User.all
  end

  def show
    @topics = Topic.where(user_id: @user.id)
  end

  def update
    @user.update(user_params)
    redirect_to admin_user_path(@user)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :profile_image, :is_deleted)
    end
end
