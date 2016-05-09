class Student < User
  has_many :teaches, foreign_key: :student_id
  has_many :teachers, through: :teaches

  has_many :enrolls, foreign_key: :student_id
  has_many :courses, through: :enrolls
  # has_many :teachers_in_contact, -> { where('"teaches"."is_accept" = true ') }, through: :teaches, source: :teacher

  def teachers_in_contact
    teachers.where("teaches.is_accept = ?", true)
  end

  def teachers_requested
    teachers.where("teaches.is_accept = ?", false).where("requester_id = ?", id)
  end

  def teachers_unaccepted
    teachers.where("teaches.is_accept = ? and requester_id = teaches.teacher_id", false)
  end

  def is_teacher_in_contact?(teacher_id)
    teaches.exists?(teacher_id: teacher_id, is_accept: true);
  end

  def is_teacher_requested?(teacher_id)
    teaches.exists?(teacher_id: teacher_id, is_accept: false, requester_id: id);
  end

  def is_teacher_unaccepted?(teacher_id)
    teaches.exists?(teacher_id: teacher_id, is_accept: false, requester_id: teacher_id);
  end

  def learn(teacher)
    return if (is_teacher_in_contact?(teacher.id) || is_teacher_requested?(teacher.id))
    if (is_teacher_unaccepted?(teacher.id))
      item = teaches.find_by(teacher_id: teacher.id, is_accept: false, requester_id: teacher.id);
      item.update_attribute(:is_accept, true);
    else
      teaches.create(teacher_id: teacher.id, requester_id: id, is_accept: false)
    end
  end

  def unlearn(teacher)
    return unless teaches.exists?(teacher_id: teacher.id)
    teaches.find_by(teacher_id: teacher.id).destroy
  end

  def is_student_in_course?(course)
    enrolls.exists?(course_id: course.id)
  end

  def enroll_course(course)
    return if is_student_in_course?(course)
    enrolls.create(course_id: course.id)
  end

  def leave_course(course)
    return unless is_student_in_course?(course)
    enrolls.find_by(course_id: course.id).destroy
  end
end