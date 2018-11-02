class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :reset_today, only: :show
  before_action :reset_user_show_params, only: :show
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    @punches = Punch.where(user_id: params[:id])
    session[:show_page] = params[:show_tag]
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
      if @user.save
        log_in @user
        flash.now[:success] = "Welcome to PunchApp App!"
        redirect_to @user
      else
        render 'new'
      end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to 'root_url'
  end
  
  #before_action
  def reset_user_show_params
    params[:show_tag] = "stamps" if params[:show_tag] == nil
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture, :group)
    end
  
    #beforeアクション
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
