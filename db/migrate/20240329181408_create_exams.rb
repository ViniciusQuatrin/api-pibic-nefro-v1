class CreateExams < ActiveRecord::Migration[7.1]
  def change
    create_table :exams do |t|
      t.references :patients, null: false, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
