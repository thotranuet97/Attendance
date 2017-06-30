class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show, :edit, :update]

  def show
    @user = User.find_by(id: params[:id])
    time_now = Time.zone.now
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

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
