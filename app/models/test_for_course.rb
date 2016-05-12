class TestForCourse < ActiveRecord::Base
  belongs_to :course, foreign_key: :course_id
  belongs_to :test, foreign_key: :test_id
end
