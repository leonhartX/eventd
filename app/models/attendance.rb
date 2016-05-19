class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :user_id, :event_id, presence: true
  validates :state, inclusion: { in: %w(attended waiting absented), message: "%{value} is not a valid state" }

  def attending?
    state && state != "absented"
  end

  class << self
    def states
      [:attended, :waiting, :absented]
    end
  end
end
