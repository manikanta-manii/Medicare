FactoryBot.define do

  factory :appointment do
    status { 'scheduled' }
    slot_time { Faker::Time.forward(days: 5) }
    reason { Faker::Lorem.sentence }
    feedback { nil }
    rating { nil }
    association :doctor
    association :patient
  end


end
