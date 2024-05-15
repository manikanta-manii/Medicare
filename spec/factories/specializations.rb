FactoryBot.define do
    
  factory :specialization do
    name { Faker::Job.field }
    description { Faker::Lorem.paragraph }
  end
  end