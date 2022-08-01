class Public::TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :update, :destroy]


  def index
    @topics = Topic.all.reverse
    if params[:sort] == "shuffle"
      @topics = @topics.shuffle
    end
  end

  def create
    @topic = current_user.topics.new(topic_params)
    input_tags = tag_params[:name].split #入力タグを配列に変換する
    input_tags.each do |tag|
      new_tag = Tag.find_or_create_by(name: tag) #タグモデルに存在していれば、そのタグを使用し、なければ新規登録する
      @topic.tags << new_tag #登録するトピックのtagにインプットする（中間テーブルにも反映される）
    end
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
    registered_tags = @topic.tags.pluck(:name).map!(&:to_s)
    input_tags = tag_params[:name].split #入力タグを配列に変換する
    new_tags = input_tags - registered_tags #追加されたタグ
    destroy_tags = registered_tags - input_tags #削除されたタグ
    new_tags.each do |tag| #新しいタグをモデルに追加
      new_tag = Tag.find_or_create_by(name: tag)
      @topic.tags << new_tag
    end
    destroy_tags.each do |tag| #削除されたタグを中間テーブルから削除
      tag_id = Tag.find_by(name: tag)
      destroy_tagging = Tagging.find_by(tag_id: tag_id, topic_id: @topic.id)
      destroy_tagging.destroy
    end
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
    @topics.reverse
  end

  def tag_search
    @tag=Tag.find(params[:tag_id])
    @topics = @tag.topics.reverse
    if params[:sort] == "shuffle"
      @topics = @topics.shuffle
    end
  end

  def word_search
    search = Topic.ransack(params[:q])
    @results = search.result.reverse
    @title_or_content_cont = params[:q][:title_or_content_cont] # シャッフルのために必要
    @tags_name_cont = params[:q][:tags_name_cont] # シャッフルのために必要
    if params[:q][:sort] == "shuffle"
      @results = @results.shuffle
    end
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
