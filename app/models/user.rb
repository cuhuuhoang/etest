class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  TYPES = [:teacher, :student]

  mount_uploader :avatar, PictureUploader


  validates_presence_of :full_name
  validates_presence_of :type
  validate :avatar_size

  private
  #sao ?
  #validate the sizes of an uploaded avatar
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "cần nhỏ hơn 5MB");
    end
  end
end
