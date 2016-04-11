class Teacher < User
  has_many :teaches, foreign_key: :teacher_id
  has_many :students, through: :teaches

  def teaching?(student)
    students.find_by(id: student.id).present?
  end

  def teach(student)
    teaches.create student: student
  end

  def unteach(student)
    return unless teaching?(student)
    students.find_by(id: student.id).destroy
  end

  class << self

  end
end