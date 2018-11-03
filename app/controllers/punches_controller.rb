class PunchesController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :reset_today, only: [:create, :update]
  before_action :reset_show_params, only: [:index]

  def index
    @punches = Punch.where(punch_date: choice_date)
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
      if params[:punch][:status] == "in"  
        if already_punch_in?  
          flash[:error] = "本日の出社時間はすでに打刻済みです"
          redirect_to '/punches'
        else 
          @punch = @user.punches.new(status: params[:punch][:status], 
                                     punch_at_in: Time.new,
                                     punch_date: Time.new)
          if @punch.save 
            flash[:success] = "打刻が完了しました"
            redirect_to '/punches'
          end
        end
      else  
        if already_punch_out?
          flash[:error] = "本日の退社時間はすでに打刻済みです"
          redirect_to '/punches'
        else
          punches = Punch.where(user_id: params[:punch][:user_id])
          @punch = punches.find_by(punch_date: Time.new) 
          @punch.update_attributes(status: "out", punch_at_out: Time.new)
          if @punch.save  
            flash[:success] = "打刻が完了しました"
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
    if params[:edit] == "in" 
      session[:punch_at] = "in"
    else  
      session[:punch_at] = nil
    end
  end

  def update
    @punch = Punch.find_by(id: params[:id])
    if session[:punch_at] == "in" 
      @punch.punch_at_in = Time.zone.local(params[:punch]["punch_at_in(1i)"].to_i, params[:punch]["punch_at_in(2i)"].to_i, params[:punch]["punch_at_in(3i)"].to_i, params[:punch]["punch_at_in(4i)"].to_i, params[:punch]["punch_at_in(5i)"].to_i)
      @punch.punch_date = Time.zone.local(params[:punch]["punch_at_in(1i)"].to_i, params[:punch]["punch_at_in(2i)"].to_i, params[:punch]["punch_at_in(3i)"].to_i)
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
    Punch.find(params[:id]).destroy
    flash[:success] = "打刻を削除しました"
    redirect_to root_url
  end
  
  # 今日の打刻がすでに存在するかどうかを判別する
  def already_punch_in?
    punch = Punch.find_by(user_id: params[:punch][:user_id], punch_date: Time.new)
    !punch.nil?
  end
  
  def already_punch_out?
    punch = Punch.find_by(user_id: params[:punch][:user_id], punch_date: Time.new)
    !punch.punch_at_out.nil?
  end
  
  # beforeアクション
  
  def correct_user
    punch = Punch.find_by(id: params[:id])
    user_id = punch.user_id
    @user = User.find(user_id)
    redirect_to(root_url) unless current_user?(@user)
  end
  
  def reset_show_params
    session[:show_page] = nil
  end
end