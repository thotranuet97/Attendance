class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    time_now = Time.zone.now
    @this_month = time_now.strftime("%Y-%m")
    @attendances = {}
    @data = {}
    @user.attendances.each{|x|
      time_in = x.time_in.strftime("%H:%M")
      time_out = x.time_out.nil? ? "?" : x.time_out.strftime("%H:%M")
      @attendances[x.date.to_s] = {number: "#{time_in}<br>#{time_out}".html_safe}
      @data[x.date.to_s] = {id: x.id, time_in: time_in, time_out: time_out}
    }

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_user(@user).deliver
      flash[:success] = t("controller.users.success")
      redirect_to admin_users_url
    else
      flash.now[:danger] = t("controller.users.fail")
      render :new
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.destroy
      flash[:success] = t("controller.users.success")
      redirect_to admin_users_url
    else
      flash.now[:danger] = t("controller.users.fail")
      redirect_to admin_users_url
    end
  end

  def lock
    @user = User.find_by(id: params[:user_id])
    @user.update_attribute(:lock, true)
    redirect_to admin_users_path
  end

  def unlock
    @user = User.find_by(id: params[:user_id])
    @user.update_attribute(:lock, false)
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:full_name, :user_name, :email)
      .merge(password: Settings.default_password)
  end
end
