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
      @punch = @user.punches.new(status: params[:punch][:status])
      if @punch.status == "in"
        @punch.punch_at_in = Time.now
      else
        @punch.punch_at_out = Time.now
      end
      if @punch.save
        flash.now[:success] = "打刻が完了しました"
        redirect_to '/punches'
      end
    else
      flash[:error] = "パスワードが正しくありません"
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
      @punch.punch_at_in = Time.zone.local(params[:punch]["punch_at_in(1i)"].to_i,
                                           params[:punch]["punch_at_in(2i)"].to_i,
                                           params[:punch]["punch_at_in(3i)"].to_i,
                                           params[:punch]["punch_at_in(4i)"].to_i,
                                           params[:punch]["punch_at_in(5i)"].to_i)
    else
      @punch.punch_at_out = Time.zone.local(params[:punch]["punch_at_out(1i)"].to_i,
                                            params[:punch]["punch_at_out(2i)"].to_i,
                                            params[:punch]["punch_at_out(3i)"].to_i,
                                            params[:punch]["punch_at_out(4i)"].to_i,
                                            params[:punch]["punch_at_out(5i)"].to_i)
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

end

=begin
  
punch_data = Punch.find_by(user_id: current_user.id)
  if punch_data.nil
    @punch = @user.punch.new(punch_at_in: punch_time_now, status: params[:punch][:status])
      if @punch.save
        flash.now[:success] = "打刻が完了しました" 
        redirect_to '/punches'
      end
  else
    if punch_data.punch_at_in.include(today)
      
    
  
  
#    SELECT * FROM punches WHERE user_id == user.id AND Time.today

#    where("カラム名 like '%検索テキスト%'")

def create
    user = User.find_by(id: params[:punch][:user_id])
    if user && user.authenticate(params[:punch][:password])
      log_in user
      @user = user
      params[:punch][:status].nil?
      @punch = @user.punch.new(status: params[:punch][:status])
      if @punch.save
        if @punch.status == "in"
          @punch.punch_at_in = punch_time_now
        else
          
          @punch.status = "out"
          @punch.punch_at_out = pundh_time_now
        flash.now[:success] = "打刻が完了しました"
        redirect_to '/punches'
      end
    else
      flash[:error] = "パスワードが正しくありません"
      redirect_to root_url
    end
  end
  
=end