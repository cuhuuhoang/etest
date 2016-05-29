class Course < ActiveRecord::Base
  has_many :enrolls, dependent: :destroy
  has_many :students, through: :enrolls

  has_many :test_for_courses, dependent: :destroy
  has_many :tests, through: :test_for_courses

  has_many :new_student_courses, dependent: :destroy

  belongs_to :teacher

  validates_presence_of :name
end
