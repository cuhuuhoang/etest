class Course < ActiveRecord::Base
  has_many :enrolls, dependent: :destroy
  has_many :students, through: :enrolls
  belongs_to :teacher

  validates_presence_of :name
end
