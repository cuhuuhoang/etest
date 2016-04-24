class Teach < ActiveRecord::Base
  belongs_to :teacher, foreign_key: :teacher_id
  belongs_to :student, foreign_key: :student_id
  validates :teacher_id, presence: true
  validates :student_id, presence: true

  scope :in_contact, -> { where is_accept: true }
  scope :requested, -> (user_id) { where is_accept: false, requester_id: user_id}
end