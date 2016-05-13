class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :state, inclusion: { in: %w(attended waiting absented), message: "%{value} is not a valid state" }

  def attending?
    state && state != "absented"
  end
end