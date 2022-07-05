class Public::TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]


  def index
  end

  def create
    @topic = current_user.topics.new(topic_params)
    tag_list = tag_params[:name].split
    tag_list.each do |tag|
      registered_tag = Tag.find_or_create_by(name: tag)
      @topic.tags << registered_tag
    end
    @topic.save
    binding.pry
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy

  end

  private

  def topic_params
    params.require(:topic).permit(:title, :content)
  end

  def tag_params
    params.require(:topic).permit(:name)
  end
end
