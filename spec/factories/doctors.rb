FactoryBot.define do
    factory :doctor do
        rating { 0.0 }
        years_of_experiance { 2 } 
        consultation_fee {150}
        specialization_id {create(:specialization).id}
        user_id {create(:user).id}
    end
end