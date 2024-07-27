class Exam < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  validates :date, presence: true
  validates :result, presence: true
end
