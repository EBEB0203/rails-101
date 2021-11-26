class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :destroy] #代表new.create需要登入
  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end
  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user
    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  def destroy
    @post = Post.find(params[:id])
    if current_user != @post.user
      redirect_to root_path, alert: "You have no permission."
    end
    @post.destroy
    flash[:alert] = "posts deleted"
    redirect_to account_posts_path
  end
  private
  def post_params
    params.require(:post).permit(:content)
  end
end
