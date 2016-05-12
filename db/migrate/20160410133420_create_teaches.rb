class CreateTeaches < ActiveRecord::Migration
  def change
    create_table :teaches do |t|
      t.integer :teacher_id, index: true
      t.integer :student_id, index: true
      t.integer :requester_id
      t.boolean :is_accept, default: false

      t.timestamps null: false
    end
  end
end
