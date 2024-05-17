require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:user_p) { FactoryBot.create(:user,role: 2) }
  let(:user_a) { FactoryBot.create(:user,role: 0) }
  let(:user_d) { FactoryBot.create(:user,role: 1) }
  let(:patient) { FactoryBot.create(:patient, user: user_p) }
  let!(:medicine) {FactoryBot.create(:medicine)}
  let!(:order) {FactoryBot.create(:order,patient: patient,ordered: false,total_price:0)}
  let!(:order_item) {FactoryBot.create(:order_item,order: order,medicine: medicine,quantity: 2, price:medicine.price*2)}
    
  
  describe "current_user" do

    it "returns the current user" do
         sign_in patient.user
        expect(helper.current_user).to eq(user_p)  
    end

    it 'returns nil if no user is signed in' do
        sign_out patient.user
      expect(helper.active_user).to be_nil
    end
end

describe '#check_user_signed_in' do
it 'executes the block if user is signed in' do
  sign_in patient.user
  expect { |b| helper.check_user_signed_in(&b) }.to yield_control
end

it 'does not execute the block if user is not signed in' do
  sign_out patient.user
  expect { |b| helper.check_user_signed_in(&b) }.not_to yield_control
end
end

describe '#check_user_not_signed_in' do
it 'executes the block if user is not signed in' do
  sign_out user_p
  expect { |b| helper.check_user_not_signed_in(&b) }.to yield_control
end

it 'does not execute the block if user is signed in' do
  sign_in user_p
  expect { |b| helper.check_user_not_signed_in(&b) }.not_to yield_control
end
end

describe '#check_if_current_user_is_admin' do
it 'executes the block if user is signed in and is admin' do
 
  sign_in user_a
  expect { |b| helper.check_if_current_user_is_admin(&b) }.to yield_control
end

it 'does not execute the block if user is not signed in or is not admin' do

  sign_in user_p
  expect { |b| helper.check_if_current_user_is_admin(&b) }.not_to yield_control
  sign_out user_p
  expect { |b| helper.check_if_current_user_is_admin(&b) }.not_to yield_control
end
end


describe '#check_if_current_user_is_patient' do
it 'executes the block if user is signed in and is a patient' do
  sign_in user_p
  expect { |b| helper.check_if_current_user_is_patient(&b) }.to yield_control
end

it 'does not execute the block if user is not signed in or is not a patient' do
  sign_in user_a
  expect { |b| helper.check_if_current_user_is_patient(&b) }.not_to yield_control
  sign_out user_a
  expect { |b| helper.check_if_current_user_is_patient(&b) }.not_to yield_control
end
end


describe '#check_if_current_user_is_patient_or_none' do
    it 'executes the block if user is not signed in' do
      sign_out user_p
      expect { |b| helper.check_if_current_user_is_patient_or_none(&b) }.to yield_control
    end

    it 'executes the block if user is signed in and is a patient' do
      sign_in user_p
      expect { |b| helper.check_if_current_user_is_patient_or_none(&b) }.to yield_control
    end

    it 'does not execute the block if user is signed in and is not a patient' do
      sign_in user_a
      expect { |b| helper.check_if_current_user_is_patient_or_none(&b) }.not_to yield_control
    end
  end


  describe '#check_if_current_user_is_doctor' do
    it 'executes the block if user is signed in and is a doctor' do
      sign_in user_d
      expect { |b| helper.check_if_current_user_is_doctor(&b) }.to yield_control
    end

    it 'does not execute the block if user is not signed in or is not a doctor' do

      sign_in user_p
      expect { |b| helper.check_if_current_user_is_doctor(&b) }.not_to yield_control
      sign_out user_p
      expect { |b| helper.check_if_current_user_is_doctor(&b) }.not_to yield_control
    end
  end

  describe '#render_profile_pic_if_attached' do
  it 'renders the block if user has an attached avatar' do
    user_p.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'avatars','default_avatar.png')), filename: 'default_avatar.png', content_type: 'image/png')
    expect { |b| helper.render_profile_pic_if_attached(user_p, &b) }.to yield_control
  end

  it 'does not render the block if user does not have an attached avatar' do
    expect { |b| helper.render_profile_pic_if_attached(user_p, &b) }.not_to yield_control
  end
end

describe '#render_default_pic_if_profile_pic_not_attached' do
it 'renders the block if user does not have an attached avatar' do
  expect { |b| helper.render_default_pic_if_profile_pic_not_attached(user_p, &b) }.to yield_control
end

it 'does not render the block if user has an attached avatar' do
  user_p.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'avatars','default_avatar.png')), filename: 'default_avatar.png', content_type: 'image/png')
  expect { |b| helper.render_default_pic_if_profile_pic_not_attached(user_p, &b) }.not_to yield_control
end
end


describe '#get_cart_items_count' do



    it 'returns the count of order items for the active user' do
      sign_in patient.user
      expect(helper.get_cart_items_count).to eq(1)
    end

    it 'returns 0 if the user is not a patient or has no orders' do
      sign_in user_a
      expect(helper.get_cart_items_count).to eq(0)
    end
  end

  describe '#get_cart_total' do

  
  it 'returns the total price of the order items' do
    sign_in patient.user
    total_price = order.order_items.pluck(:price).sum
    expect(helper.get_cart_total(order.order_items)).to eq(total_price)
  end
end

end