class PatientQuestion < ApplicationRecord
  belongs_to :patient
  belongs_to :question

  serialize :response, Array  # Para armazenar múltiplas respostas (checkbox)

  validates :response, presence: true
end
