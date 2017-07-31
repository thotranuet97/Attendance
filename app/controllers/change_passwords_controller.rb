class ChangePasswordsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

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
    params.require(:user).permit(:password, :password_confirmation)
      .merge(first_password: false)
  end
end
