FactoryBot.define do
    factory :appointment do
      slot_time { Faker::Date.forward(14) }
      reason { Faker::Lorem.sentence(word_count: 3) } 
      status { 'scheduled' }
      doctor_id {create(:doctor).id}
      patient_id {create(:patient).id}
      feedback { nil } 
      rating{nil}
    end
  end