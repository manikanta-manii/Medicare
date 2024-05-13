FactoryBot.define do
    factory :specialization do
      name { Faker::Job.title } 
      description { Faker::Lorem.sentence(word_count: 3) }  
    end
  end