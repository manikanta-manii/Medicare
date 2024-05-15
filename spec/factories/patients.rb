FactoryBot.define do
   
  factory :patient do
    gender { ['Male', 'Female'].sample }
    dob { Faker::Date.birthday }
    blood_type { Faker::Blood.type }
    association :user
  end
end