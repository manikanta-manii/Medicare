require 'rails_helper'

RSpec.describe User, type: :model do

  it 'name cannot be blank' do 
    user = build(:user,name: nil)
    expect(user).to_not be_valid
  end

  it 'name cannot be blank' do 
    user = build(:user,name: "manikanta")
    expect(user).to be_valid
  end

  it 'phone number must be 10 digit' do 
    user = build(:user,phone_number: "9019785436")
    expect(user).to be_valid
  end

  it 'phone number must be 10 digit' do 
    user = build(:user,phone_number: 1)
    expect(user).to_not be_valid
  end

  it "does not allow duplicate email" do
    user1 = create(:user,email: "manikanta@gmail.com")
    user2 = build(:user,email:"manikanta@gmail.com")
    expect(user2).to_not be_valid
  end


end
