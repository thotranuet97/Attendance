class AttendancesController < ApplicationController
  before_action :require_admin, only: :destroy

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

  def update
    attendance = Attendance.find_by(id: params[:id])
    if attendance.update_attributes(attendance_params)
      flash[:success] = t("controller.attendances.success")
      redirect_to admin_user_path(attendance.user_id)
    else
      flash[:danger] = t("controller.attendances.fail")
      redirect_to admin_user_path(attendance.user_id)
    end
  end

  def destroy
    attendance = Attendance.find_by(id: params[:id])
    attendance.destroy
    redirect_to admin_user_path(attendance.user_id)
  end

  private
  def attendance_params
    params.require(:attendance).permit(:date, :time_in, :time_out)
  end
end
