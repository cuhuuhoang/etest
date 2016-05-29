class EtestMailer < ApplicationMailer
  default from: "noreply@exam.edu.vn"

  def new_student(student, teacher, course)
    @student = student
    @teacher = teacher
    @course = course
    mail(to: @student.email, subject: 'Thông báo tài khoản mới')
  end
end
