class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  
  validates :phone_number, presence: true, numericality: { only_integer: true }, format: { with: /\A\d{10}\z/, message: "must be a 10-digit number" }
   
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
