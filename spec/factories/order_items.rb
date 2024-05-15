FactoryBot.define do
    factory :order_item do
        quantity { Faker::Number.between(from: 1, to: 10) }
        price { Faker::Number.between(from: 1, to: 100) }
        association :order
        association :medicine
      end
end