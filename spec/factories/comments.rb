FactoryGirl.define do
  factory :comment do
    content "Some comment"
    user
    event
  end
end
