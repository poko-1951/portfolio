class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:create, :destroy]

  def create
    comment = current_user.comments.new(comment_params)
    comment.topic_id = @topic.id
    comment.save
  end

  def destroy
    Comment.find(params[:id]).destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end

    def set_topic
      @topic = Topic.find(params[:topic_id])
    end
end
