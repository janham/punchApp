class StaticPagesController < ApplicationController
  before_action :reset_today
  
  def home
#    if logged_in?
      @users = User.all
#      paginate(page: params[:page])
#      @post  = current_user.posts.build
#      @feed_items = current_user.feed.paginate(page: params[:page])
#    end
    @punch = Punch.new
  end

  def about
  end
end
