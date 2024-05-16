FactoryBot.define do

  factory :appointment do
    status { 'scheduled' }
    slot_time { Time.now().to_s }
    reason { Faker::Lorem.sentence }
    feedback { nil }
    rating { nil }
    association :doctor
    association :patient
  end


end
