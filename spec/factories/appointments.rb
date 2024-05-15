FactoryBot.define do

  factory :appointment do
    status { 'scheduled' }
    slot_time { Faker::Time.forward(days: 5) }
    reason { Faker::Lorem.sentence }
    feedback { Faker::Lorem.paragraph }
    rating { Faker::Number.between(from: 1, to: 5) }
    association :doctor
    association :patient
  end


end
