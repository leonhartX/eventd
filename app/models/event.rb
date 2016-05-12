class Event < ApplicationRecord
  belongs_to :user
  has_many :attendances, dependent: :destroy
  has_many :participant, through: :attendances, source: :user

  validates :title, :hold_at, :capacity, :location, :owner, presence: true
  validates :title, format: { with: /\A[\w\s\d]+\z/, message: "only allow letters, numbers and space" }
  validates :capacity, numericality: { greater_than_or_equal_to: 1 }

end
