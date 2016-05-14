class Test < ActiveRecord::Base
  has_many :do_tests, dependent: :destroy
  has_many :students, through: :do_tests

  has_many :test_for_courses, dependent: :destroy
  has_many :courses, through: :test_for_courses

  belongs_to :teacher

  validates_presence_of :name
  validates_numericality_of :time

  def is_test_in_course?(course)
    test_for_courses.exists?(course_id: course.id)
  end

  def add_course(course)
    return if is_test_in_course?(course)
    test_for_courses.create(course_id: course.id)
  end

  def remove_course(course)
    return unless is_test_in_course?(course)
    test_for_courses.find_by(course_id: course.id).destroy
  end
end
