FactoryBot.define do
    factory :appointment do
        association :doctor, factory: :doctor
        association :patient, factory: :patient
      slot_time { Faker::Date.forward(14) }
      reason { Faker::Lorem.sentence(word_count: 3) } 
      status { 'scheduled' }
      feedback { nil } 
      rating{nil}
    end
  end