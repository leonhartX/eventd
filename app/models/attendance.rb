class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def involved?
  	state != nil
  end

  def attending?
  	involved? && state != "absented"
  end

end