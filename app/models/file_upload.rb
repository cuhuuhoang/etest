class FileUpload < ActiveRecord::Base
  belongs_to :attachment, polymorphic: true
end
