FactoryGirl.define do
  sequence :title do |n|
    "test_event_#{n}"
  end
  factory :event do
    title
    hold_at "2026-05-11 22:05:27"
    capacity 1
    location "MyString"
    owner "MyString"
    description "MyString"
    user
  end
end
