class LoginsController < ApplicationController
  def new
    if logged_in?
      redirect_to users_path
    end
  end

  def create
    user = User.find_by(user_name: params[:login][:user_name]) ||
      User.find_by(email: params[:login][:user_name])
    if user && user.authenticate(params[:login][:password])
      if user.lock?
        flash.now[:danger] = t("controller.logins.lock")
        render :new
      else
        log_in user
        params[:login][:remember_me] == "1" ? remember(user) : forget(user)
        flash[:success] = t("controller.logins.success")
        redirect_to users_path
      end
    else
      flash.now[:danger] = t("controller.logins.invalid")
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_url
  end
end
