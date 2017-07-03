class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :require_change_password
  before_action :correct_user, only: [:show, :edit, :update]

  def show
    @user = User.find_by(id: params[:id])
    time_now = Time.zone.now
    @this_month = time_now.strftime("%Y-%m")
    @attendances = {}
    @user.attendances.each{|x|
      time_in = x.time_in.strftime("%H:%M")
      time_out = x.time_out.nil? ? "?" : x.time_out.strftime("%H:%M")
      @attendances[x.date.to_s] = {number: "#{time_in} - #{time_out}"}
    }
    @attendance = Attendance.find_by(user_id: @user.id, date: time_now)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = t("controller.users.success")
      redirect_to user_path
    else
      flash.now[:danger] = t("controller.users.fail")
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:full_name, :email, :password,
      :password_confirmation)
  end
end
