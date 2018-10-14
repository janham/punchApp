module PunchesHelper
  
  def punch_time_now
    Time.new
  end
  
  def punch_at_out?
    @punch = Punch.find_by(user_id: current_user.id)
    !@punch.punch_at_out.nil?
  end
end
