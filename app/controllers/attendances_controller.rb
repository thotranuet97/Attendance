class AttendancesController < ApplicationController
  def create
    datetime = Time.zone.now
    id = params[:attendances][:id]
    if id.present?
      attendance = Attendance.find_by(id: id)
      attendance.update_attribute(:time_out, datetime)
      flash[:success] = t("controller.attendances.success")
      redirect_to current_user
    else
      attendance = current_user.attendances.build(date: datetime, time_in: datetime)
      if attendance.save
        flash[:success] = t("controller.attendances.success")
        redirect_to current_user
      else
        flash.now[:danger] = t("controller.attendances.fail")
        render current_user
      end
    end
  end

  def destroy
  end
end
