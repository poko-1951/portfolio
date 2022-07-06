class Public::TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]


  def index
    @topics = Topic.all
  end

  def create
    @topic = current_user.topics.new(topic_params)
    tag_list = tag_params[:name].split
    tag_list.each do |tag|
      registered_tag = Tag.find_or_create_by(name: tag)
      @topic.tags << registered_tag
    end
    @topic.save
    redirect_to topics_path
  end

  def show
    @user = @topic.user
  end

  def edit
  end

  def update
  end

  def destroy
    @topic.destroy
    redirect_to request.referer
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
