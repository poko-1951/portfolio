class Admin::TopicsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_topic, only: [:show, :update, :destroy]

  def show
    @user = @topic.user
    @comment = Comment.new
  end

  def update
    @topic.update(topic_params)
    input_tags = tag_params[:name].split # 入力タグを配列に変換する
    @topic.update_tags(input_tags)
    redirect_to admin_path
  end

  def destroy
    @topic.destroy
    redirect_to admin_path
  end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @topics = @tag.topics
  end

  def word_search
    search = Topic.ransack(params[:q])
    @results = search.result
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
