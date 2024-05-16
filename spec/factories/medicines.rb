FactoryBot.define do
    factory :medicine do
        
        name { Faker::Lorem.word }
        description { Faker::Lorem.paragraph }
        dosage { Faker::Lorem.word }
        price { Faker::Number.between(from: 1, to: 100) }
        quantity { Faker::Number.between(from: 10, to: 1000) }
        need_prescription { Faker::Boolean.boolean }
      end
end