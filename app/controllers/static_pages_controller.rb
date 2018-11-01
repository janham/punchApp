class StaticPagesController < ApplicationController
  before_action :reset_today
  before_action :reset_user_group_params, only: :home
  
  def home
    @users = User.where(group: params[:user_group])
    session[:user_group] = params[:user_group]
    @punch = Punch.new
  end

  def about
  end
  
  def reset_user_group_params
    params[:user_group] = "2" if params[:user_group] == nil
  end
end
