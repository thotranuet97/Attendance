class AttendancesController < ApplicationController
  before_action :logged_in_user
  before_action :require_change_password

  def create
    datetime = Time.zone.now
    attendance = current_user.attendances.build(date: datetime, time_in: datetime)
    if attendance.save
      flash[:success] = t("controller.attendances.success")
      redirect_to users_path
    else
      flash[:danger] = t("controller.attendances.fail")
      redirect_to users_path
    end
  end

  def update
    datetime = Time.zone.now
    attendance = Attendance.find_by(user_id: current_user.id, date: datetime)
    if attendance.time_out.present?
      flash[:danger] = t("controller.attendances.fail")
    elsif attendance.update_attribute(:time_out, datetime)
      flash[:success] = t("controller.attendances.success")
    else
      flash[:danger] = t("controller.attendances.fail")
    end
    redirect_to users_path
  end
end
