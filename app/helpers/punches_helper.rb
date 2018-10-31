module PunchesHelper
  
  def punch_at_session_in?
    !session[:punch_at].nil?
  end
  
  # 記録した時間の年日を省いて単位を「時分」表示にする
  def to_time(punch)
    punch.strftime("%-k時%-M分")
  end
  
  # 記録した時間の時分を省いて単位を「年月日」表示にする
  def to_date(punch)
    punch.strftime("%Y年%-m月%-d日")
  end
  
  # プロフィールページにいるときはtrue
  def user_page?
    !session[:page].nil?
  end
end
