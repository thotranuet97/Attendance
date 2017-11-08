class Admin::LatelistsController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin

  def index
  	@users = User.all

    @check = false
    if !params[:month].nil?
      @check = true
      @users.each do |user| 
        user.attendances.each do |x|
          if (x.time_out.nil?) && x.date.mon.equal?(params[:month].to_i)
            flash.now[:danger] = user.full_name + " " + t("admin.latelists.index.time_out_nil") 
          end
        end
      end

      if params[:month].to_i < 10
        time = params[:year].to_s + '0' + params[:month].to_s 
      else
        time = params[:year].to_s + params[:month].to_s 
      end
    end

    @lists = Attendance.select('u.id, date, u.full_name as name, time_in as tin')
       .joins('inner join users as u on u.id = user_id ')
       .where('time_out IS NOT NULL 
        AND ((time_in > "08:00:00" && time_in <= "12:00:00") || time_in > "14:00:00") 
        AND extract(year_month FROM date) = ?', time)
       .reorder('')
   
    @months = ['January','February','March','April','May','June',
              'July','August','September','October','November','December']
  end
end
