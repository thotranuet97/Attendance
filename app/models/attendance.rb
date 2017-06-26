class Attendance < ActiveRecord::Base
  belongs_to :user

  default_scope -> {order(date: :desc)}

  validates :user_id, presence: true
  validates :date, presence: true
  validates :time_in, presence: true

  def Attendance.get_attendances_this_month(user, year, month)
    where("user_id = ? and
      extract(year from date) = ? and
      extract(month from date) = ?", user.id, year, month)
  end

end
