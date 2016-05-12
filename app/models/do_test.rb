class DoTest < ActiveRecord::Base
  belongs_to :student, foreign_key: :student_id
  belongs_to :test, foreign_key: :test_id
end
