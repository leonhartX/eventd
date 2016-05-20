class Event < ApplicationRecord
  belongs_to :user
  has_many :attended, -> { where state: :attended }, class_name: :Attendance
  has_many :waiting, -> { where state: :waiting }, class_name: :Attendance
  has_many :absented, -> { where state: :absented }, class_name: :Attendance
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attended, source: :user
  has_many :waiters, through: :waiting, source: :user
  has_many :absentees, through: :absented, source: :user
  has_many :properties, dependent: :destroy
  has_many :tags, through: :properties, source: :tag
  has_many :comments, dependent: :destroy

  validates :title, :hold_at, :capacity, :location, :owner, presence: true
  validates :title, :location, :owner, length: { maximum: 255 }
  validates :description, length: { maximum: 10000 }
  validates :capacity, numericality: { greater_than_or_equal_to: 1 }
  validates_datetime :hold_at, :on_or_after => :now

  def over_capacity?
    attendees.count >= capacity
  end

  def available?
    hold_at >= Time.now
  end

  def add_tag tag
    properties.find_or_create_by tag_id: tag.id
  end

  def update_participant
    return if waiters.count == 0 || over_capacity?
    waiters.order(:updated_at).first.update_attend self, "attended"
  end

  class << self
    def participant_type
      [:attendees, :waiters, :absentees]
    end
  end
end
