class Public::TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tags = Tag.all.order(:name)
  end
end
