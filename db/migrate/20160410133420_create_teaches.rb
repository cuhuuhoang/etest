class CreateTeaches < ActiveRecord::Migration
  def change
    create_table :teaches do |t|
      t.integer :teacher_id
      t.integer :student_id
      t.integer :requester_id
      t.boolean :is_accept

      t.timestamps null: false
    end
  end
end
