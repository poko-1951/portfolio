class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @topics = Topic.all
  end
end
