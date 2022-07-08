class Public::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def new
    @event = Event.new
    render plain: render_to_string(partial: 'form_new', layout: false, locals: { event: @event })
  end

  def create
    @event = current_user.events.new(event_params)
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
    @events = Event.all
  end

  def show

  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
