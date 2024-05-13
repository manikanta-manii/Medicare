FactoryBot.define do
    factory :user do
        name { Faker::Company.name }
        email {Faker::Internet.email}
        password {"Abcd@123"}
        phone_number {"9999999999"}
    end
end