class Public::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :update, :move_update, :destroy]

  def create
    @event = current_user.events.new(event_params)
    acquaintance = Acquaintance.find_by(id: params[:event][:acquaintance_id])
    @event.acquaintances << acquaintance
    if @event.save
      respond_to do |format|
        format.html { redirect_to events_path }
        format.js  #create.js.erbを探してその中の処理を実行する
      end
    else
      respond_to do |format|
        format.js {render partial: "error" }
        #登録にエラーが起きたときはerror.js.erbを実行する
      end
    end
  end

  def index
    @event = Event.new
    @events = Event.all
  end

  def show
  end

  def update
    @event.update(event_params)
    # お相手も更新できるようにする
    redirect_to event_path(@event)
  end

  def move_update
    @event.update(start: params[:update_start], end: params[:update_end])
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end, :content, :place)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
