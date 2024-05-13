FactoryBot.define do
    factory :patient do
        gender { 'male' }
        dob { 15-12-2002 } 
        blood_type { Faker::Blood.blood_type }
        user_id {build(:user).id}
    end
end