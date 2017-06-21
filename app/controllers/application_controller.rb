class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include LoginsHelper

  def login
    redirect_to login_url
  end

  private
    def logged_in_user
      if !logged_in?
      redirect_to login_url
      end
    end

    def requie_admin
      redirect_to root_url unless current_user.admin?
    end
end
