class Teach < ActiveRecord::Base
  belongs_to :teacher, :foreign_key => :student_id, :class_name => "User"
  belongs_to :student, :foreign_key => :teacher_id, :class_name => "User"
  validates :teacher_id, presence: true
  validates :student_id, presence: true
end
