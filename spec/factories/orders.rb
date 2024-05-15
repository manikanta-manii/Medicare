FactoryBot.define do
    factory :order do
        total_price { Faker::Number.between(from: 10, to: 1000) }
        ordered { Faker::Boolean.boolean }
        association :patient
        association :address
      end
end