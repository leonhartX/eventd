class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]

  def password_required?
    super && provider.blank?
  end

  def email_required?
    super && provider.blank?
  end

  class << self
    def from_oauth(auth)
      where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |user|
        user.provider = auth[:provider]
        user.uid = auth[:uid]
        user.name = auth[:info][:name]
        user.nickname = auth[:info][:nickname]
      end
    end

    def new_with_session(params, session)
      if session["devise.user_attributes"]
        debugger
        new(session["devise.user_attributes"]) do |user|
          user.attributes = params
          debugger
          user.valid?
        end
      else
        super
      end
    end
  end
end
