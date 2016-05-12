class CreateTestForCourses < ActiveRecord::Migration
  def change
    create_table :test_for_courses do |t|
      t.boolean :shown_answer, default: false
      t.datetime :open_date
      t.integer :test_id, index: true
      t.integer :course_id, index: true

      t.timestamps null: false
    end
  end
end
