class Course < ActiveRecord::Base
  has_many :enrolls
  has_many :students, through: :enrolls
  belongs_to :teacher
end
