class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_user, only: [:show, :update, :confirm, :withdrawal]

  def index
    redirect_to new_user_registration_path
  end

  def show
    @topics = Topic.where(user_id: @user.id).page(params[:page]).per(5)
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def confirm
  end

  def withdrawal
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session # 残っているsessionをこの時点で削除
    flash[:notice] = "退会処理が完了しました"
    redirect_to root_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :email_receiving_activation, :profile_image)
    end
end
