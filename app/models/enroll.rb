class Enroll < ActiveRecord::Base
  belongs_to :course, foreign_key: :course_id
  belongs_to :student, foreign_key: :student_id
  class << self

    def process_student_email(email, teacher, course)
      return if email.nil? || !is_a_valid_email?(email)
      student = User.find_by(email: email)
      if student.nil?
        student = User.new(
            :email                 => email,
            :full_name             => email.split("@")[0],
            :type                  => "Student",
            :is_admin              => false,
            :password              => "12345678",
            :password_confirmation => "12345678"
        )
        student.skip_confirmation!
        student.save!

        teacher.teach(student)
        student.learn(teacher)

        EtestMailer.new_student(student, teacher, course).deliver
      else
        teacher.teach(student)
      end

      if teacher.type == "Teacher"
        if !course.nil? && teacher.is_student_in_contact?(student.id) && course.teacher_id == teacher.id
          student.enroll_course(course)
        end
      end
    end


    def is_a_valid_email?(email)
      (email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    end
  end
end
