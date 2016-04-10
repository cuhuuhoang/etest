class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  # primary_key = :username

  has_many :studentships, :foreign_key => "teacher_id", :class_name => "Teach", dependent: :destroy
  has_many :teacherships, :foreign_key => "student_id", :class_name => "Teach", dependent: :destroy

  has_many :teachers, :through => :teacherships, :source => :student
  has_many :students, :through => :studentships, :source => :teacher

  mount_uploader :avatar, PictureUploader

  validates_uniqueness_of :username
  validates_presence_of :full_name
  validates :role, :inclusion => { :in => 1..2, :message => "phải là giáo viên/học sinh" }
  validate :avatar_size


  def teach(student)
    studentships.create(student_id: student.id)
  end

  def unteach(student)
    studentships.find_by(student_id: student.id).destroy
  end

  def teaching?(student)
    students.include?(student)
  end

  def learning?(teacher)
    teachers.include?(teacher)
  end


  private

  #validate the sizes of an uploaded avatar
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "cần nhỏ hơn 5MB");
    end
  end
end
