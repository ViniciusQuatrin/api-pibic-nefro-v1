class CreatePatientQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :patient_questions do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
