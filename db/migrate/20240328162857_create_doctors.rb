class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :crm

      t.timestamps
    end
  end
end
