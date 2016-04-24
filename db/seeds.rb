# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new(
    :email                 => "huuhoangcu@gmail.com",
    :username              => "huuhoangcu",
    :full_name             => "Cù Hữu Hoàng",
    :type                  => "Teacher",
    :is_admin              => true,
    :password              => "12345678",
    :password_confirmation => "12345678"
)
admin.skip_confirmation!
admin.save!

1.upto(10) do |i|
  teacher = User.new(
      :email                 => "teacher#{i}@exam.edu.vn",
      :username              => "teacher#{i}",
      :full_name             => "Test Teacher #{i}",
      :type                  => "Teacher",
      :is_admin              => false,
      :password              => "12345678",
      :password_confirmation => "12345678"
  )
  teacher.skip_confirmation!
  teacher.save!

  1.upto(100) do |j|
    student = User.new(
        :email                 => "student#{i}-#{j}@exam.edu.vn",
        :username              => "student#{i}-#{j}",
        :full_name             => "Test Student #{i}-#{j}",
        :type                  => "Student",
        :is_admin              => false,
        :password              => "12345678",
        :password_confirmation => "12345678"
    )
    student.skip_confirmation!
    student.save!

    teacher.teach(student)
    student.learn(teacher)
  end

  101.upto(170) do |j|
    student = User.new(
        :email                 => "student#{i}-#{j}@exam.edu.vn",
        :username              => "student#{i}-#{j}",
        :full_name             => "Test Student #{i}-#{j}",
        :type                  => "Student",
        :is_admin              => false,
        :password              => "12345678",
        :password_confirmation => "12345678"
    )
    student.skip_confirmation!
    student.save!

    student.learn(teacher)
  end

  171.upto(220) do |j|
    student = User.new(
        :email                 => "student#{i}-#{j}@exam.edu.vn",
        :username              => "student#{i}-#{j}",
        :full_name             => "Test Student #{i}-#{j}",
        :type                  => "Student",
        :is_admin              => false,
        :password              => "12345678",
        :password_confirmation => "12345678"
    )
    student.skip_confirmation!
    student.save!

    teacher.teach(student)
  end

end

