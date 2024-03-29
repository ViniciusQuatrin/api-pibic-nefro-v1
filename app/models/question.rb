class Question < ApplicationRecord
  has_many :patient_questions
  has_many :patients, through: :patient_questions

  validates :title, presence: true
  validates :short, presence: true
  validates :question, presence: true, uniqueness: { case_sensitive: false }
end
