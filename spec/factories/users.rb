FactoryBot.define do
    factory :user do
        email { Faker::Internet.email }
        password { Faker::Internet.password }
        name { Faker::Name.name }
        phone_number { "9999999999" }
        role { 2 }
    end
end