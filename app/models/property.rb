class Property < ApplicationRecord
  belongs_to :event
  belongs_to :tag
  validates :event_id, :tag_id, presence: true
end
