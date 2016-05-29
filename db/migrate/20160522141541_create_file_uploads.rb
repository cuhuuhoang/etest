class CreateFileUploads < ActiveRecord::Migration
  def change
    create_table :file_uploads do |t|
      t.string :file
      t.references :attachment, polymorphic: true, index: true
      t.string :type

      t.timestamps null: false
    end
  end
end
