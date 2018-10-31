class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # display_dateカラム内容を6桁の数字で返す
  def choice_date
    @displaydate = Displaydate.find_by(id:1)
    data = @displaydate.list_date
    to_year_date(data).to_i
  end
  
  # display_dateを今日の日付にリセットする
  def reset_today
    @displaydate = Displaydate.find_by(id:1)
    @displaydate.list_date = today
  end
  
  # 年日のみの文字列に変換するメソッド
  def to_year_date(data)
    data.year.to_s + data.month.to_s + data.day.to_s
  end
  
  # 今日の年日のみを8桁の数列で返す
  def today
    now = Time.new
    return to_year_date(now).to_i
  end
  
  # before_action
  
  def not_user_page
    session[:page] = nil
  end
  
  private
  
    def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "ログインしてください"
          redirect_to login_url
        end
    end
end
