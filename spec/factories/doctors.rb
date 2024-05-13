FactoryBot.define do
    factory :doctor do
        rating { 0.0 }
        years_of_experiance { 2 } 
        consultation_fee {150}
        specialization_id {build(:specialization).id}
        user_id {build(:user).id}
    end
end