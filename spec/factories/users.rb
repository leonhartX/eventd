FactoryGirl.define do
  sequence :name do |n|
    "user_#{n}"
  end

  sequence :uid do |n|
    "123456789#{n}"
  end

  factory :user do
    name
    nickname "test nickname"
    description "test user"
    image "http://test"
    provider "twitter"
    uid
    token "some token"
    secret "some secret"
    sharable true
  end
end
