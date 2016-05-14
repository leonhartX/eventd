class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:update, :destroy]

  def index
    @events = Event.paginate(page: params[:page])
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
    @event = current_user.events.build event_params
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @events = []
    if request.post? then
      query = params[:search]
      @events = Event.where("title like '%" + query + "%'")
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :hold_at, :capacity, :location, :owner, :description)
    end

    def correct_user
      event = current_user.events.find_by(id: params[:id])
      redirect_to root_path if event.nil?
    end
end
