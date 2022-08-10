class Public::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :update, :move_update, :destroy]

  def create
    @event = current_user.events.new(event_params)
    if @event.valid?
      @event.save
      params[:event][:acquaintance_ids].reject(&:blank?).each do |acquaintance|
        acquaintance = Acquaintance.find_by(id: acquaintance)
        @event.acquaintances << acquaintance
      end
      respond_to do |format|
        format.html { redirect_to events_path }
        format.js  # create.js.erbを探してその中の処理を実行する
      end
    else
      flash[:alert] = "終了日時が開始日時を上回っています。正しく記入してください。"
      redirect_to events_path
    end
  end

  def index
    @event = Event.new
    @events = current_user.events
  end

  def show
  end

  def update
    if @event.valid? && @event.update(event_params)
      input_acquaintances = params[:event][:acquaintance_ids].reject(&:blank?)
      @event.update_acquaintance(input_acquaintances)
    else
      flash[:alert] = "終了日時が開始日時を上回っています。正しく記入してください。"
    end
    redirect_to event_path(@event)
  end

  def move_update
    @event.update(start_at: params[:update_start], end_at: params[:update_end])
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private
    def event_params
      params.require(:event).permit(:title, :start_at, :end_at, :content, :place)
    end

    def set_event
      @event = Event.find(params[:id])
    end
end
