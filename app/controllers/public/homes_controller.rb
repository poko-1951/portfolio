class Public::HomesController < ApplicationController
  before_action :user_signed_in, only: [:top]
  before_action :admin_signed_in, only: [:top]

  def top
  end

  private
    def user_signed_in
      redirect_to topics_path if user_signed_in?
    end

    def admin_signed_in
      redirect_to admin_path if admin_signed_in?
    end
end
