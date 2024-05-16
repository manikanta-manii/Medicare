FactoryBot.define do
    factory :doctor do
        rating { }
        years_of_experiance { Faker::Number.between(from: 1, to: 50) }
        consultation_fee { Faker::Number.between(from: 101, to: 1500) }
        association :user
        association :specialization
      end
end