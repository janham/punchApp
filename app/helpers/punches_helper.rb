module PunchesHelper
  
  def punch_at_session_in?
    !session[:punch_at].nil?
  end
  
end
