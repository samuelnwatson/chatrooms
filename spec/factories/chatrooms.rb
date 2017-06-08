FactoryGirl.define do
  factory :chatroom do
    topic { Faker::StarWars.unique.wookie_sentence.parameterize }
    description { Faker::TwinPeaks.unique.quote }
    slug  { topic.parameterize }
    creator { Faker::TwinPeaks.character.parameterize }
  end
end
