class Admin::StatisticsController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin

  def index
    query_month = Attendance.connection.select_all(
      "SELECT DISTINCT extract(month FROM a.date) AS month
         FROM attendances AS a 
         WHERE a.time_out IS NOT NULL"
      )
    @month = query_month.rows

    query_year = Attendance.connection.select_all(
    	"SELECT DISTINCT extract(year FROM a.date) AS year
         FROM attendances AS a 
         WHERE a.time_out IS NOT NULL"
    	)
    @year = query_year.rows

    @test = true
    time = 8
    
    @total_time = Attendance.select('u.full_name as name, 
      sec_to_time(sum(time_to_sec(timediff(time_out, time_in)))) as time')
        .joins('inner join users as u on u.id = user_id ')
        .where('time_out IS NOT NULL AND extract(month FROM date) = ?', time)
        .group('user_id')
        
  end

end