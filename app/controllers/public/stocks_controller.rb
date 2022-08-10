class Public::StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:create, :update, :destroy]

  # 特定せずにストックする（お気に入り登録）
  def create
    stock = current_user.stocks.new(topic_id: @topic.id, acquaintance_id: nil)
    stock.save
    @topic.create_notification_favorite(current_user)
  end

  # 特定せずにストックしたものを外す
  def destroy
    stock = current_user.stocks.find_by(topic_id: @topic.id, acquaintance_id: nil)
    stock.destroy
  end

  # 特定のお相手にストックする（外すことも可能）
  def update
    input_stock_acquaintances = params[:stock][:acquaintance_ids].reject(&:blank?)
    @topic.update_stock(input_stock_acquaintances, current_user)
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
