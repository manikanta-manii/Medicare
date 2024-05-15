FactoryBot.define do
    factory :address do
      country { Faker::Address.country }
      state { Faker::Address.state }
      city { Faker::Address.city }
      street { Faker::Address.street_address }
      association :patient
    end
end