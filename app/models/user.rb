class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :involvements, through: :attendances, source: :event
  devise :database_authenticatable, :trackable, :timeoutable,
    :omniauthable, omniauth_providers: [:twitter]

  def password_required?
    super && provider.blank?
  end

  def attend event
    state = event.over? ? "waiting" : "attended"
    attendances.create(event_id: event.id, state: state)
  end

  def update_attend event, state
    state = "waiting" if state == "attended" && event.over?
    attendances.find_by(user_id: id, event_id: event.id).update_attribute :state, state
  end

  class << self
    def from_oauth(auth)
      where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |user|
        user.provider = auth[:provider]
        user.uid = auth[:uid]
        user.name = auth[:info][:name]
        user.nickname = auth[:info][:nickname]
        user.description = auth[:info][:description]
        user.image = auth[:info][:image]
      end
    end

    def new_with_session(params, session)
      if session["devise.user_attributes"]
        new(session["devise.user_attributes"]) do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end
  end
end
