FactoryBot.define do
  factory :todo do
    title { Faker::Lorem.sentence }
    status { Faker::Number.between(from: 0, to: 2) }
    user
  end
end
