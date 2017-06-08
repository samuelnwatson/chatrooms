FactoryGirl.define do
  factory :post do
    sequence(:content) { |n| "Generated post #{n}" }
    chatroom
    user
  end
end
