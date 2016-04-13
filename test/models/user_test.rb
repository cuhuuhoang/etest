require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should teach and study a user" do
    teacher1 = users(:teacher1)
    student1 = users(:student1)
    # list = teacher1.students_in_contact
    # assert list.include(student1)
    # assert teacher1.students_requested.include(student1)
    # assert teacher1.students_unaccepted.include(student1)
    assert_not_includes teacher1.students_in_contact, student1
    assert_not teacher1.is_student_in_contact?(student1)
    assert_not teacher1.is_student_requested?(student1)
    assert_not teacher1.is_student_unaccept?(student1)

    assert_not student1.is_teacher_in_contact?(teacher1)
    assert_not student1.is_teacher_requested?(teacher1)
    assert_not student1.is_teacher_unaccept?(teacher1)
    assert_not_includes teacher1.students_requested, student1

    teacher1.teach(student1)

    assert_not teacher1.is_student_in_contact?(student1)
    assert_includes teacher1.students_requested, student1

    assert teacher1.is_student_requested?(student1)
    assert_not teacher1.is_student_unaccept?(student1)

    assert_not student1.is_teacher_in_contact?(teacher1)
    assert_not student1.is_teacher_requested?(teacher1)
    assert student1.is_teacher_unaccept?(teacher1)

    student1.learn(teacher1)
    assert_includes teacher1.students_in_contact, student1
    assert_includes student1.teachers_in_contact, teacher1
    assert teacher1.is_student_in_contact?(student1)
    assert_not teacher1.is_student_requested?(student1)
    assert_not teacher1.is_student_unaccept?(student1)

    assert student1.is_teacher_in_contact?(teacher1)
    assert_not student1.is_teacher_requested?(teacher1)
    assert_not student1.is_teacher_unaccept?(teacher1)


  end
end
