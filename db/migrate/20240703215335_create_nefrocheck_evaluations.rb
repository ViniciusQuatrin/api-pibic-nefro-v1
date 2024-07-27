class CreateNefrocheckEvaluations < ActiveRecord::Migration[7.1]
  def change
    create_table :nefrocheck_evaluations do |t|
      t.references :patient, null: false, foreign_key: true
      t.decimal :tfg
      t.boolean :referral_needed
      t.string :message
      t.text :details

      t.timestamps
    end
  end
end
