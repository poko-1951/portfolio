class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tags, only: [:index, :destroy_index]

  def index
  end

  def destroy_index
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to destroy_index_admin_tags_path
  end

  private
    def set_tags
      @tags = Tag.all.order(:name)
    end
end
