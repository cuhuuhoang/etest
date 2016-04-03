class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  validates_uniqueness_of :username
  validates_presence_of :full_name
  validates :role, :inclusion => { :in => 1..2, :message => "phải là giáo viên/học sinh" }
end
