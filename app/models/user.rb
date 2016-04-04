class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  mount_uploader :avatar, PictureUploader

  validates_uniqueness_of :username
  validates_presence_of :full_name
  validates :role, :inclusion => { :in => 1..2, :message => "phải là giáo viên/học sinh" }
  validate :avatar_size

  private

  #validate the sizes of an uploaded avatar
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "cần nhỏ hơn 5MB");
    end
  end
end
