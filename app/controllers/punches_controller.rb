class PunchesController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def index
    @punches = Punch.all
  end

  def create
    user = User.find_by(id: params[:punch][:user_id])
    @user = user
    if user && user.authenticate(params[:punch][:password])
      if logged_in?
        log_out
        log_in user
      else
        log_in user
      end
      if params[:punch][:status] == "in"  #出社を選択してPunchした時
        if already_punch_in?  #すでに出社時間を打刻済の時
          flash[:error] = "本日の出社時間はすでに打刻済みです"
          redirect_to '/punches'
        else  #新しく打刻時間を作成する時
          @punch = @user.punches.new(status: params[:punch][:status], punch_at_in: Time.new)
          data = @punch.punch_at_in
          @punch.punch_date = to_year_date(data).to_i #打刻年日のみを抽出してpunch_dateカラムへ
          if @punch.save  #出社時間の打刻が保存された時
            flash.now[:success] = "打刻が完了しました"
            redirect_to '/punches'
          end
        end
      else  #退社を選択してPunchした時
        if already_punch_out?
          flash[:error] = "本日の退社時間はすでに打刻済みです"
          redirect_to '/punches'
        else
          punches = Punch.where(user_id: params[:punch][:user_id])
          @punch = punches.find_by(punch_date: today) #ユーザー&出社時間が一致するデータを抽出
          @punch.update_attributes(status: "out", punch_at_out: Time.new)
          if @punch.save  #退社時間の打刻が保存された時
            flash.now[:success] = "打刻が完了しました"
            redirect_to '/punches'
          end
        end
      end
    else
      flash[:error] = "アカウントが未選択、またはパスワードが正しくありません"
      redirect_to root_url
    end
  end

  def edit
    @punch = Punch.find_by(id: params[:id])
    if params[:edit] == "in"  #編集リンク(出社時間)を押した時
      session[:punch_at] = "in"
    else  #編集リンク(退社時間)を押した時
      session[:punch_at] = nil
    end
  end

  def update
    @punch = Punch.find_by(id: params[:id])
    if session[:punch_at] == "in" #編集更新リンク(出社時間)を押した時
      @punch.punch_at_in = Time.zone.local(params[:punch]["punch_at_in(1i)"].to_i, params[:punch]["punch_at_in(2i)"].to_i, params[:punch]["punch_at_in(3i)"].to_i, params[:punch]["punch_at_in(4i)"].to_i, params[:punch]["punch_at_in(5i)"].to_i)
      in_date = Time.zone.local(params[:punch]["punch_at_in(1i)"].to_i, params[:punch]["punch_at_in(2i)"].to_i, params[:punch]["punch_at_in(3i)"].to_i)
      @punch.punch_date = to_year_date(in_date).to_i
    else  #編集更新リンク(退社時間)を押した時
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
    Punch.find(params[:id]).destroy
    flash[:success] = "打刻を削除しました"
    redirect_to root_url
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
  
  #今日の打刻がすでに存在するかどうかを判別する
  def already_punch_in?
    punch = Punch.find_by(user_id: params[:punch][:user_id], punch_date: today)
    !punch.nil?
  end
  
  def already_punch_out?
    punch = Punch.find_by(user_id: params[:punch][:user_id], punch_date: today)
    !punch.punch_at_out.nil?
  end
  
  #beforeアクション
  
  def correct_user
    punch = Punch.find_by(id: params[:id])
    user_id = punch.user_id
    @user = User.find(user_id)
    redirect_to(root_url) unless current_user?(@user)
  end
end