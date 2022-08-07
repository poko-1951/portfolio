class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @topic = Topic.find(params[:topic_id])
    Comment.find(params[:id]).destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
