class Enroll < ActiveRecord::Base
  belongs_to :course
  belongs_to :student, foreign_key: :student_id
end
