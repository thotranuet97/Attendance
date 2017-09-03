class StatisticsController < ApplicationController
 
  def total
    @users = User.all
    @user = User.find_by(id: params[:user_id])
  end

end
