class PunchesController < ApplicationController

  def index
    @punches = Punch.all
  end

  def create
    user = User.find_by(id: params[:punch][:user_id])
    if user && user.authenticate(params[:punch][:password])
      if logged_in?
        log_out
        log_in user
      else
        log_in user
      end
      @user = user
      if params[:punch][:status] == "in"
        @punch = @user.punches.new(status: params[:punch][:status], punch_at_in: Time.new)
        data = @punch.punch_at_in
        @punch.punch_date = to_year_date(data).to_i
      else
        punches = Punch.where(user_id: params[:punch][:user_id])
        @punch = punches.find_by(punch_date: today)
        @punch.punch_at_out = Time.new
      end
      if @punch.save
        flash.now[:success] = "打刻が完了しました"
        redirect_to '/punches'
      end
    else
      flash[:error] = "アカウントが未選択、またはパスワードが正しくありません"
      redirect_to root_url
    end
  end

  def edit
    @punch = Punch.find_by(id:params[:id])
    if params[:edit] == "in"  #出社時間の編集リンク
      session[:punch_at] = "in"
    else                      #退社時間の編集リンク 
      session[:punch_at] = nil
    end
  end

  def update
    @punch = Punch.find_by(id:params[:id])
    if session[:punch_at] == "in"
      @punch.punch_at_in = Time.zone.local(params[:punch]["punch_at_in(1i)"].to_i, params[:punch]["punch_at_in(2i)"].to_i, params[:punch]["punch_at_in(3i)"].to_i, params[:punch]["punch_at_in(4i)"].to_i, params[:punch]["punch_at_in(5i)"].to_i)
    else
      @punch.punch_at_out = Time.zone.local(params[:punch]["punch_at_out(1i)"].to_i, params[:punch]["punch_at_out(2i)"].to_i, params[:punch]["punch_at_out(3i)"].to_i, params[:punch]["punch_at_out(4i)"].to_i, params[:punch]["punch_at_out(5i)"].to_i)
    end
    if @punch.save
      flash[:success] = "打刻時間を更新しました"
      redirect_to '/punches'
    else
      render 'edit'
    end
  end

  def destroy
  end
  
  #年日のみの文字列に変換するメソッド
  def to_year_date(data)
    data.year.to_s + data.month.to_s + data.day.to_s
  end
  
  #今日の年日のみを返すメソッド
  def today
    now = Time.new
    return to_year_date(now).to_i
  end
end