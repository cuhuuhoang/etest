class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :name
      t.text :description
      t.text :questions
      t.text :question_index
      t.text :answers
      t.text :answer_index
      t.string :type
      t.integer :time
      t.integer :teacher_id, index: true

      t.timestamps null: false
    end
  end
end
