class Admin::TopicsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

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
