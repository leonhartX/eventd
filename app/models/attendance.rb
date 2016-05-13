class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def attending?
  	state && state != "absented"
  end
end