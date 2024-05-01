# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# User.create(name:"Admin",phone_number:"9999999999",email:"admin@gmail.com",password:"Admin@123",role:0);
# Specialization.create(name:"Cardiologist",description:"Heart related doctor !");
# Specialization.create(name:"Neurologist",description:"A neurologist treats conditions of the nerves, spine, and brain");
# Specialization.create(name:"General Physician",description:" a primary care doctor who specializes in family medicine and can treat a wide range of physical and mental problems for patients of all ages and genders.");
# Specialization.create(name:"Gynecologist",description:"A gynecologist diagnoses and treats issues with female reproductive organs. ");
# seeds.rb

# Seed data for medicines
medicines_data = [
  {
    name: "Paracetamol",
    description: "Used to treat mild to moderate pain and to reduce fever.",
    dosage: "500mg",
    price: 5,
    quantity: 100,
    need_prescription: false
  },
  {
    name: "Amoxicillin",
    description: "An antibiotic used to treat a variety of bacterial infections.",
    dosage: "250mg",
    price: 10,
    quantity: 50,
    need_prescription: true
  },
  {
    name: "Omeprazole",
    description: "Used to reduce the amount of acid produced by the stomach.",
    dosage: "20mg",
    price: 8,
    quantity: 80,
    need_prescription: false
  },

]


medicines_data.each do |medicine_params|
  Medicine.create!(medicine_params)
end
