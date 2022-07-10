class Public::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :update, :move_update, :destroy]

  def create
    @event = current_user.events.new(event_params)
    # acquaintance = Acquaintance.find_by(id: params[:event][:acquaintance_id])
    # @event.acquaintances << acquaintance
    if @event.valid?
      @event.save
      params[:event][:acquaintance_ids].reject(&:blank?).each do |ac|
        acquaintance = Acquaintance.find_by(id: ac)
        @event.acquaintances << acquaintance
      end
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
    if @event.valid?
      @event.update(event_params)
      registered_acquaintances = @event.acquaintances.pluck(:id)
      new_acquaintances = params[:event][:acquaintance_ids].reject(&:blank?) - registered_acquaintances
      destroy_acquaintances = registered_acquaintances -  params[:event][:acquaintance_ids].reject(&:blank?)
      new_acquaintances.each do |new|
        acquaintance = Acquaintance.find_by(id: new)
        @event.acquaintances << acquaintance
      end
      destroy_acquaintances.each do |destroy|
        acquaintance_id = Acquaintance.find_by(id: destroy)
        destroy_schedule = Schedule.find_by(acquaintance_id: acquaintance_id, event_id: @event.id)
        destroy_schedule.destroy
      end
    end
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
