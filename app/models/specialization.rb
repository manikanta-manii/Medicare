class Specialization < ApplicationRecord
    has_many :doctors, dependent: :destroy
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "id_value", "name", "updated_at"]
    end
end
