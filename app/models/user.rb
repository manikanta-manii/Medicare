class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :patient,dependent: :destroy,inverse_of: :user
  accepts_nested_attributes_for :patient

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:admin, :doctor, :patient]

 after_initialize :set_default_role, if: :new_record?

 def set_default_role
   self.role ||= :patient
 end
end
