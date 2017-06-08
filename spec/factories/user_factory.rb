FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.unique.email }
    username { Faker::TwinPeaks.unique.character.parameterize }
    password { "password" }
  end

  trait :admin do
    admin true
  end
end
