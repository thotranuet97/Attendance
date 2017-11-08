class Admin::StatisticsController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin

  def index
    @users = User.all
    @test = false
    if !params[:month].nil? && !params[:year].nil?
      @test = true
      @users.each do |user| 
        user.attendances.each do |x|
          if (x.time_out.nil?) && x.date.mon.equal?(params[:month].to_i)
            flash.now[:danger] = user.full_name + " " + t("admin.statistics.index.time_out_nil") 
          end
        end
      end
      if params[:month].to_i < 10
        time = params[:year].to_s + '0' + params[:month].to_s 
      else
        time = params[:year].to_s + params[:month].to_s 
      end
    end
  
    @total_time = Attendance.select('u.id, u.full_name as name, 
      sum(time_to_sec(timediff(time_out, time_in))) as time')
        .joins('inner join users as u on u.id = user_id ')
        .where('time_out IS NOT NULL AND extract(year_month FROM date) = ?', time)
        .group('user_id')
        .reorder('')  
    
    @months = ['January','February','March','April','May','June',
              'July','August','September','October','November','December']
  end
end
