class Teacher < User
  has_many :teaches, foreign_key: :teacher_id
  has_many :students, through: :teaches
  has_many :students_in_contact, -> { in_contact }, through: :teaches, source: :student
  # has_many :students_requested, -> { where('"teaches"."is_accept" = true AND requester_id ') }, through: :teaches, source: :student

  def students_in_contact
    students.where("teaches.is_accept = ?", true)
  end

  def students_requested
    students.where("teaches.is_accept = ?", false).where("requester_id = ?", id)
  end

  def students_unaccepted
    students.where("teaches.is_accept = ? and requester_id = teaches.student_id", false)
  end

  def is_student_in_contact?(student)
    teaches.exists?(student_id: student.id, is_accept: true);
  end

  def is_student_requested?(student)
    teaches.exists?(student_id: student.id, is_accept: false, requester_id: id);
  end

  def is_student_unaccept?(student)
    teaches.exists?(student_id: student.id, is_accept: false, requester_id: student.id);
  end

  def teach(student)
    return if (is_student_in_contact?(student) || is_student_requested?(student))
    if (is_student_unaccept?(student))
      item = teaches.find_by(student_id: student.id, is_accept: false, requester_id: student.id);
      item.update_attribute(:is_accept, true);
    else
      teaches.create(student_id: student.id, requester_id: id, is_accept: false)
    end
  end

  def unteach(student)
    return unless teaches.exists?(student_id: student.id)
    teaches.find_by(student_id: student.id).destroy
  end
end