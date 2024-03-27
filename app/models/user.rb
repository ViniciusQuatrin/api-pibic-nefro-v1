class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
  validates :profile, presence: true

  enum profile: { patient: 0, doctor: 1, admin: 2 }
end
