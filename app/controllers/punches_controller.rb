class PunchesController < ApplicationController
  
  def index
  end

  def show
  end

  def create
    @punch = Punch.new(punch_params)
    @user = User.find(punch_params[:user_id])
    if @punch.save
      flash[:success] = "打刻が完了しました"
    end
  end

  def edit
  end

  def destroy
  end
  
  def punch_time_now
    Time.new
  end
  
  def punch_params
    
  end
  
end
