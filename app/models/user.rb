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

  def patient?
    self.profile == "patient"
  end

  def doctor?
    self.profile == "doctor"
  end

  def admin?
    self.profile == "admin"
  end
end
