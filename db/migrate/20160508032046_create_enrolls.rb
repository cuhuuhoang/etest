class CreateEnrolls < ActiveRecord::Migration
  def change
    create_table :enrolls do |t|
      t.references :course, index: true, foreign_key: true
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
