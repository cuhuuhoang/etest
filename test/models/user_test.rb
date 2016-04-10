require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should teach and study a user" do
    teacher1 = users(:teacher1)
    student1 = users(:student1)
    assert_not teacher1.teaching?(student1)
    assert_not student1.learning?(teacher1)

    teacher1.teach(student1)
    # assert_equal User.all, 1
    # assert_equal Teach.all, 1
    assert teacher1.teaching?(student1)
    assert student1.learning?(teacher1)

    assert teacher1.students.include?(student1)

    teacher1.unteach(student1)
    assert_not teacher1.teaching?(student1)
  end
end
