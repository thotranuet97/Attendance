class Attendance < ActiveRecord::Base
  belongs_to :user

  default_scope -> {order(date: :desc)}

  validates :user_id, presence: true
  validates :date, presence: true, uniqueness: {scope: :user_id}
  validates :time_in, presence: true
  validate :time_in_time_out

  def Attendance.get_attendances(user, year, month)
    where("user_id = ? and
      extract(year from date) = ? and
      extract(month from date) = ?", user.id, year, month)
  end

  def time_in_time_out
    if time_out.present?
      errors.add(:base, "Time in later than time out") if time_in > time_out
    end
  end
end
