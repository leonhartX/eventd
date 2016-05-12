class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def create
    @event = Event.find_by(id: params[:event_id])
    if Attendance.find_by(user_id: current_user.id, event_id: params[:event_id])
      flash[:success] = "Already attended."
    elsif @event
      current_user.attend @event
      flash[:success] = "Attned to #{@event.title}!"
    else
      flash[:danger] = "Event not existed!"
    end
    redirect_to @event
  end

  def update
  	# binding.pry
    @event = Event.find_by(id: params[:event_id])
    if !Attendance.find_by(user_id: current_user.id, event_id: params[:event_id])
    elsif @event
      current_user.update_attend @event, params[:state]
      flash[:success] = "Attned to #{@event.title}!"
    else
      flash[:danger] = "Event not existed!"
    end
    redirect_to @event
  end

  def destroy

  end

end
