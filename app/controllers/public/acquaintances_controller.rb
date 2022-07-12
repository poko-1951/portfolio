class Public::AcquaintancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_acquaintance, only: [:show, :update, :destroy]

  def index
    @acquaintances = Acquaintance.all
  end

  def create
    @acquaintance = current_user.acquaintances.new(acquaintance_params)
    @acquaintance.save
    redirect_to acquaintances_path
  end

  def show
    @topics = @acquaintance.topics
  end

  def update
    @acquaintance.update(acquaintance_params)
    redirect_to acquaintance_path(@acquaintance)
  end

  def destroy
    @acquaintance.destroy
    redirect_to acquaintances_path
  end

  private

  def acquaintance_params
    params.require(:acquaintance).permit(:name, :relationship, :character, :like)
  end

  def set_acquaintance
    @acquaintance = Acquaintance.find(params[:id])
  end
end
