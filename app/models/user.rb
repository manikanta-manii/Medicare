class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+\z/,
                                 message: "must contain at least one lowercase letter, one uppercase letter, one digit, and one special character" }
  validates :phone_number, presence: true,uniqueness: true,numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :phone_number, length: { is: 10, message: "should be exactly 10 digits" }



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
