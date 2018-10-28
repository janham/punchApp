module PunchesHelper
  
  def punch_at_session_in?
    !session[:punch_at].nil?
  end
  
  # 記録した時間の年日を省いて単位を「時・分」表示にする
  def to_time(punch)
    punch.strftime("%-k時%-M分")
  end
end
