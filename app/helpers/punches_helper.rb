module PunchesHelper
  
  def punch_at_session_in?
    !session[:punch_at].nil?
  end
  
  def datetime_ja
    strftime("%Y年%-m月%-d日 %-H時%-M分%-S秒")
  end
end
