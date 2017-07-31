class Admin::AttendancesController < ApplicationController
  before_action :require_admin, only: [:update, :destroy]

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
