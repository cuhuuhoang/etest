class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.integer :teacher_id, index: true
      t.boolean :closed, default: false

      t.timestamps null: false
    end
  end
end
