class Patient < ApplicationRecord
  belongs_to :user
  has_many :appointments
  has_many :patient_questions
  has_many :questions, through: :patient_questions
  has_many :exams

  validates :name, presence: true
  validates :sex, presence: true
  validates :creatinine, presence: true
  validates :race, presence: true

  enum sex: { masc: 0, fem: 1 }
  enum race: { white: 0, black: 1 }

  def has_prior_exams?
    exams.present?
  end

  include PatientEvaluation
end
