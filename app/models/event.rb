class Event < ApplicationRecord
  belongs_to :user
  has_many :attended, -> { where state: "attended" }, class_name: 'Attendance'
  has_many :waiting, -> { where state: "waiting" }, class_name: 'Attendance'
  has_many :absented, -> { where state: "absented" }, class_name: 'Attendance'
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attended, source: :user
  has_many :waiters, through: :waiting, source: :user
  has_many :absentees, through: :absented, source: :user

  validates :title, :hold_at, :capacity, :location, :owner, presence: true
  validates :capacity, numericality: { greater_than_or_equal_to: 1 }
  validates_datetime :hold_at, :on_or_after => :now

  def over?
  	attendees.count >= capacity
  end

  def update_participant
  	return if waiters.count == 0 || attendees.count >= capacity
  	waiters.order(:updated_at).first.update_attend self, "attended"
  end

  class << self
  	def participant_type
  		['attendees', 'waiters', 'absentees']
  	end
  end
end