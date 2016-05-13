FactoryGirl.define do
  factory :attendance do
    user
    event
    state "attended"
  end
end