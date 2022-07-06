class Admin::TopicsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_topic, only: [:show, :update, :destroy]

  def show
    @user = @topic.user
  end

  def update
    @topic.update(topic_params)
    registered_tags = @topic.tags.pluck(:name)
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
    redirect_to admin_path
  end

  def destroy
    @topic.destroy
    redirect_to admin_path
  end
  
  def tag_search
    @tag=Tag.find(params[:tag_id])
    @topics = @tag.topics
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
