class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_one :patient
  has_one :doctor

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :profile, presence: true

  enum profile: { patient: 0, doctor: 1, admin: 2 }
end
