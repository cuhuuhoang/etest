class Student < User
  has_many :teaches, foreign_key: :student_id
  has_many :teachers, through: :teaches

  def learning?(teacher_id)
    teachers.find_by(id: teacher_id)
  end
end