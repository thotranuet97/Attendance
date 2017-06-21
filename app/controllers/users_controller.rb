class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :requie_admin, only: [:index, :new, :create, :destroy]

  def show
    @user = User.find_by(id: params[:id])
    time_now = Time.zone.now
    @attendance = Attendance.find_by(user_id: @user.id, date: time_now)
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t("controller.users.success")
      redirect_to users_url
    else
      flash.now[:danger] = t("controller.users.fail")
      render :new
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.destroy
      flash[:success] = t("controller.users.success")
      redirect_to users_url
    else
      flash.now[:danger] = t("controller.users.fail")
      redirect_to users_url
    end

  end

  private
    def user_params
      params.require(:user).permit(:full_name, :user_name, :email,
        :password, :password_confirmation)
    end
end
