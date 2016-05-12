class Test < ActiveRecord::Base
  has_many :do_tests, dependent: :destroy
  has_many :students, through: :do_tests

  has_many :test_for_courses, dependent: :destroy
  has_many :courses, through: :test_for_courses

  belongs_to :teacher

  validates_presence_of :name
  validates_numericality_of :time
end
