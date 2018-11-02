class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # display_dateカラム内容を数字で返す
  def choice_date
    @displaydate = Displaydate.find_by(id:1)
    @displaydate.list_date
  end
  
  # display_dateを今日の日付にリセットする
  def reset_today
    displaydate = Displaydate.find_by(id:1)
    displaydate.list_date = Time.new
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
