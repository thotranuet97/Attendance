class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :require_change_password
  before_action :correct_user, only: [:edit, :update]

  def index
    time_now = Time.zone.now
    @this_month = time_now.strftime("%Y-%m")
    @attendances = {}
    current_user.attendances.each{|x|
      time_in = x.time_in.strftime("%H:%M")
      time_out = x.time_out.nil? ? "?" : x.time_out.strftime("%H:%M")
      @attendances[x.date.to_s] = {number: "#{time_in}<br>#{time_out}".html_safe}
    }
    @attendance = Attendance.find_by(user_id: current_user.id, date: time_now)
  end

  def edit
  end

  def update
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
