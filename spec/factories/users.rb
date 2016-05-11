FactoryGirl.define do
  factory :user do
    name "leonhart"
    nickname "leon"
    description "test user"
    image "http://test"
    provider "twitter"
    uid "125361990"
  end
end
