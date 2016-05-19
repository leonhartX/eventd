class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :user_id, :event_id, :content, presence: true
  validates :content, length: { minimum: 1, maximum: 2000 }
end
