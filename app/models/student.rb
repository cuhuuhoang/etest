class Student < User
  has_many :teaches, foreign_key: :student_id
  has_many :teachers, through: :teaches
  # has_many :teachers_in_contact, -> { where('"teaches"."is_accept" = true ') }, through: :teaches, source: :teacher

  def teachers_in_contact
    teachers.where("teaches.is_accept = ?", true)
  end

  def teachers_requested
    teachers.where("teaches.is_accept = ?", false).where("requester_id = ?", id)
  end

  def teachers_unaccepted
    teachers.where("teaches.is_accept = ? and requester_id = teaches.teacher_id", false, id)
  end

  def is_teacher_in_contact?(teacher)
    teaches.exists?(teacher_id: teacher.id, is_accept: true);
  end

  def is_teacher_requested?(teacher)
    teaches.exists?(teacher_id: teacher.id, is_accept: false, requester_id: id);
  end

  def is_teacher_unaccept?(teacher)
    teaches.exists?(teacher_id: teacher.id, is_accept: false, requester_id: teacher.id);
  end

  def learn(teacher)
    return if (is_teacher_in_contact?(teacher) || is_teacher_requested?(teacher))
    if (is_teacher_unaccept?(teacher))
      item = teaches.find_by(teacher_id: teacher.id, is_accept: false, requester_id: teacher.id);
      item.update_attribute(:is_accept, true);
    else
      teaches.create(teacher_id: teacher.id, requester_id: id, is_accept: false)
    end
  end

  def unlearn(teacher)
    return unless teaches.exists?(id: student.id)
    teaches.find_by(teacher_id: teacher.id).destroy
  end
end