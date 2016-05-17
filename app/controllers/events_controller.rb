class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :share]
  before_action :correct_user, only: [:update, :destroy]

  def index
    @events = Event.order(updated_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def show
    if current_user.id
      @attendance = @event.attendances.find_by(user_id: current_user.id) || current_user.attendances.build
    end
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    binding.pry
    @event = current_user.created_events.build event_params
    if @event.save
      params[:event][:tags].split(",").each do |t|
        tag = Tag.find_or_create_by name: t.strip.downcase
        @event.add_tag tag
      end
      redirect_to @event, flash: { success: 'Event was successfully created.' }
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, flash: { success: 'Event was successfully updated.' }
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, flash: { success: 'Event was successfully destroyed.' }
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :hold_at, :capacity, :location, :owner, :description)
  end

  def correct_user
    event = current_user.created_events.find_by(id: params[:id])
    redirect_to root_path if event.nil?
  end
end
