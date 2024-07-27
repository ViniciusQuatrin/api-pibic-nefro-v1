class Question < ApplicationRecord
  has_many :patient_questions
  has_many :patients, through: :patient_questions

  validates :title, presence: true
  validates :short, presence: true
  validates :question, presence: true, uniqueness: { case_sensitive: false }
  validates :question_type, presence: true, inclusion: { in: %w[radio checkbox text] }

  enum question_type: { radio: 0, checkbox: 1, text: 2 }
end
