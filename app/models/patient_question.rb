class PatientQuestion < ApplicationRecord
  belongs_to :patient
  belongs_to :question
end
