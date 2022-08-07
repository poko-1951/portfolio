class Public::StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:create, :update, :destroy]

  # 特定せずにストックする（お気に入り登録）
  def create
    stock = current_user.stocks.new(topic_id: @topic.id, acquaintance_id: nil)
    stock.save
    # redirect_to topic_path(@topic)
  end

  # 特定せずにストックしたものを外す
  def destroy
    stock = current_user.stocks.find_by(topic_id: @topic.id, acquaintance_id: nil)
    stock.destroy
    # redirect_to topic_path(@topic)
  end

  # 特定のお相手にストックする（外すことも可能）
  def update
    registered_acquaintances = @topic.acquaintances.pluck(:id).map!(&:to_s)
    new_acquaintances = params[:stock][:acquaintance_ids].reject(&:blank?) - registered_acquaintances
    destroy_acquaintances = registered_acquaintances - params[:stock][:acquaintance_ids].reject(&:blank?)
    new_acquaintances.each do |new|
      stock = current_user.stocks.new(acquaintance_id: new, topic_id: @topic.id)
      stock.save
    end
    destroy_acquaintances.each do |destroy|
      acquaintance_id = Acquaintance.find_by(id: destroy)
      destroy_schedule = Stock.find_by(acquaintance_id: acquaintance_id, topic_id: @topic.id)
      destroy_schedule.destroy
    end
    redirect_to topic_path(@topic)
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end

    def set_topic
      @topic = Topic.find(params[:topic_id])
    end
end
