class Public::AcquaintancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @acquaintances = Acquaintance.all
  end

  def create
    @acquaintance = current_user.acquaintances.new(acquaintance_params)
    @acquaintance.save
    redirect_to acquaintances_path
  end

  def edit
  end

  private

  def acquaintance_params
    params.require(:acquaintance).permit(:name, :relationship, :character, :like)
  end
end
