class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :phone_number, presence: true,uniqueness: true,numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :phone_number, length: { is: 10, message: "should be exactly 10 digits" }



  has_one :patient,dependent: :destroy,inverse_of: :user
  has_one :doctor,dependent: :destroy,inverse_of: :user
  accepts_nested_attributes_for :patient

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:admin, :doctor, :patient]

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
   self.role ||= :patient
  end
end
