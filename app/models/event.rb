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
  validates :title, format: { with: /\A[\w\s\d]+\z/, message: "only allow letters, numbers and space" }
  validates :capacity, numericality: { greater_than_or_equal_to: 1 }

  def over?
  	attendees.count >= capacity
  end
end