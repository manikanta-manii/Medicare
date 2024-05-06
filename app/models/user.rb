class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  has_one :patient,dependent: :destroy,inverse_of: :user
  has_one :doctor,dependent: :destroy,inverse_of: :user

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :phone_number, presence: true, numericality: { only_integer: true }, format: { with: /\A\d{10}\z/, message: "must be a 10-digit number" }
   
  
  accepts_nested_attributes_for :patient
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:admin, :doctor, :patient]

  after_initialize :set_default_role, if: :new_record?

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "id_value", "name", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["avatar_attachment", "avatar_blob", "doctor", "patient"]
  end

  def set_default_role
   self.role ||= :patient
  end

end
