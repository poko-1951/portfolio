class Public::TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :update, :destroy]


  def index
    @topics = Topic.order(updateed_at: "DESC").page(params[:page]).per(5)
    @topics.order!('random()').page(params[:page]).per(5) if params[:sort] == "shuffle"
  end

  def create
    @topic = current_user.topics.new(topic_params)
    input_tags = tag_params[:name].split # 入力タグを配列に変換する
    @topic.create_tags(input_tags)
    @topic.save
    redirect_to topics_path
  end

  def show
    @user = @topic.user
    @comment = Comment.new
    @stock = Stock.new
  end

  def update
    @topic.update(topic_params)
    input_tags = tag_params[:name].split # 入力タグを配列に変換する
    @topic.update_tags(input_tags)
    redirect_to request.referer
  end

  def destroy
    @topic.destroy
    redirect_to topics_path
  end

  def favorite_topics
    @stocks = current_user.stocks.where(acquaintance_id: nil)
    @topics = []
    @stocks.each do |stock|
      topic = Topic.find(stock.topic_id)
      @topics << topic
    end
    @topics = Topic.where(id: @topics.map{ |topic| topic.id })
    @topics = @topics.order(updateed_at: "DESC").page(params[:page]).per(5)
  end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @topics = @tag.topics.order(updateed_at: "DESC").page(params[:page]).per(5)
    @topics.order!('random()').page(params[:page]).per(5) if params[:sort] == "shuffle"
  end

  def word_search
    search = Topic.ransack(params[:q])
    @results = search.result.order(updateed_at: "DESC").page(params[:page]).per(5)
    # @title_or_content_cont = params[:q][:title_or_content_cont] # シャッフルのために必要
    # @tags_name_cont = params[:q][:tags_name_cont] # シャッフルのために必要
    @topics.order!('random()').page(params[:page]).per(5) if params[:sort] == "shuffle"
  end

  private
    def topic_params
      params.require(:topic).permit(:title, :content)
    end

    def tag_params
      params.require(:topic).permit(:name)
    end

    def set_topic
      @topic = Topic.find(params[:id])
    end
end
