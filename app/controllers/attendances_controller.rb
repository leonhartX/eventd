class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]
  before_action :check_event, only: [:create, :update]

  def create
    if Attendance.find_by(user_id: current_user.id, event_id: params[:event_id])
      flash[:success] = "Already involved."
    else
      current_user.attend @event
      flash[:success] = "Attned to #{@event.title}!"
    end
    redirect_to @event
  end

  def update
    if !Attendance.find_by(user_id: current_user.id, event_id: params[:event_id])
      flash[:danger] = "Not involved yet!"
    else
      current_user.update_attend @event, params[:state]
      flash[:success] = "State updated."
    end
    redirect_to @event
  end

  private
    def check_event
      @event = Event.find_by(id: params[:event_id])
      redirect_to root_path unless @event
    end
end
