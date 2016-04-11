class Teach < ActiveRecord::Base
  belongs_to :teacher, foreign_key: :teacher_id
  belongs_to :student, foreign_key: :student_id
  validates :teacher_id, presence: true
  validates :student_id, presence: true
end
