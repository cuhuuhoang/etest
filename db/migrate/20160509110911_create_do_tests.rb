class CreateDoTests < ActiveRecord::Migration
  def change
    create_table :do_tests do |t|
      t.text :answer
      t.float :current_score
      t.float :first_score
      t.float :highest_score
      t.integer :test_id, index: true
      t.integer :student_id, index: true

      t.timestamps null: false
    end
  end
end
