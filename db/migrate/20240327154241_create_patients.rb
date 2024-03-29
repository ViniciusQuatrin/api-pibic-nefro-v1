class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :sex
      t.decimal :creatinine
      t.integer :race
      t.decimal

      t.timestamps
    end
  end
end
