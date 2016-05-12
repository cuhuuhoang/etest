class CreateEnrolls < ActiveRecord::Migration
  def change
    create_table :enrolls do |t|
      t.integer :course_id, index: true
      t.integer :student_id, index: true

      t.timestamps null: false
    end
  end
end
