namespace :db do
  task sample: [:environments, 'db:migrate:reset'] do
    User.create(email: 'huuhoangcu@gmail.com', username: "huuhoangcu", full_name: "Cù Hữu Hoàng", type: "Teacher", is_admin: true, password: "12345678")
  end
end



# 1.upto(1) do |i|
#   teacher = User.new(
#       :email                 => "teacher#{i}@exam.edu.vn",
#       :username              => "teacher#{i}",
#       :full_name             => "Test Teacher #{i}",
#       :type                  => "Teacher",
#       :is_admin              => false,
#       :password              => "12345678",
#       :password_confirmation => "12345678"
#   )
#   teacher.skip_confirmation!
#   teacher.save!
#
#   student = User.new(
#       :email                 => "student#{i}@exam.edu.vn",
#       :username              => "student#{i}",
#       :full_name             => "Test Student #{i}",
#       :type                  => "Student",
#       :is_admin              => false,
#       :password              => "12345678",
#       :password_confirmation => "12345678"
#   )
#   student.skip_confirmation!
#   student.save!
#
#   teacher.teach(student)
#   student.learn(teacher)
# end