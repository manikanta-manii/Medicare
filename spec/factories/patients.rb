FactoryBot.define do
   
  factory :patient do
    gender { ['male', 'female'].sample }
    dob { Faker::Date.birthday }
    blood_type { ['A+', 'A-'].sample }
    association :user
  end
end