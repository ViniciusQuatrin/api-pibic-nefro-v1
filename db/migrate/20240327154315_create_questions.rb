class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :short
      t.string :title
      t.text :question
      t.text :answer

      t.timestamps
    end
  end
end