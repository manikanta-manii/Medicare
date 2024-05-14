FactoryBot.define do
    factory :medicine do
        name { "medicine" } 
        description { Faker::Lorem.sentence(word_count: 3) }   
        dosage {2}
        price {20}
        quantity {10}
        need_prescription {false}   
    end
end