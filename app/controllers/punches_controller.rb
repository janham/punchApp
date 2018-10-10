class PunchesController < ApplicationController
  
  def index
  end

  def show
  end

  def create
    user = User.find_by(id: params[:punch][:user_id])
    if user && user.authenticate(params[:punch][:password])
      log_in user
      @user = user
      @punch = Punch.new(user_id: params[:punch][:user_id],
                         status: params[:punch][:status],
                         punch_at: punch_time_now)
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
  end

  def destroy
  end
  
  def punch_time_now
    Time.new
  end
  
end
