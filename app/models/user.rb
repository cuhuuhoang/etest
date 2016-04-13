class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  # primary_key = :username
  TYPES = [:teacher, :student]

  mount_uploader :avatar, PictureUploader

  validates_uniqueness_of :username
  validates_presence_of :full_name
  validates_presence_of :type
  validate :avatar_size

  def request_teach(other_user)
    #check role
    if role == Roles::Teacher && other_user.role == Roles::Student

    elsif role == Roles::Student && other_user.role == Roles::Teacher

    end
    #create
  end

  def confirm_teach(other_user)
    #check equal id
    #check who request
    #update
  end

  private
  #sao ?
  #validate the sizes of an uploaded avatar
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "cần nhỏ hơn 5MB");
    end
  end
end
