FactoryBot.define do
  factory :activity do
    title { Faker::Lorem.word }
    frequency { Faker::Number.between(from: 1, to: 5) }
  end
end