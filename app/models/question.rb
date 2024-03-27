class Question < ApplicationRecord
  has_many :patient_questions
  has_many :patients, through: :patient_questions

  validates :question, presence: true
end
