class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy] 
  before_action :correct_user,   only: :destroy
  
  def index
    if logged_in?
      @posts = Post.all
      @post  = current_user.posts.build
    else
      flash[:error] = "ログインしてください"
      redirect_to root_url
    end
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash.now[:success] = "投稿しました"
      redirect_to '/posts'
    else
      flash.now[:error] = "内容を入力して投稿してください"
      @feed_items = current_user.feed.paginate(page: params[:page])
      redirect_to '/posts'
    end
  end

  def destroy
    @post.destroy
    flash.now[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:content, :picture)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
  
end
