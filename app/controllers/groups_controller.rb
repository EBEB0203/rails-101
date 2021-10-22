class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy] #authenticate_user!是 devise 提供的内建功能。
                                                   #before_action :authenticate_user! 后面不加任何东西，表示这个 controller 下的所有 action 都要登入。
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy] #在def edit.update.destroy開頭執行find_group_and_check_permission
  def index
    @group = Group.all #撈出所有的群
  end
  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      redirect_to groups_path #重新連結到首頁
    else
      render:new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "Update Success"
    else
      render:edit
    end
  end

  def destroy
    @group.destroy
    flash[:alert] = "Group deleted"
    redirect_to groups_path
  end

 private
 def find_group_and_check_permission
   @group = Group.find(params[:id])
   if current_user != @group.user
     redirect_to root_path, alert: "You have no permission."
   end
 end

 def group_params
   params.require(:group).permit(:title, :description)
 end
end
