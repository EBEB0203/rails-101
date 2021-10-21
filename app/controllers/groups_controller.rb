class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new] #authenticate_user!是 devise 提供的内建功能。
                                                   #before_action :authenticate_user! 后面不加任何东西，表示这个 controller 下的所有 action 都要登入。
  def index
    @group = Group.all #撈出所有的群
  end
  def new
    @group = Group.new
  end
  def show
    @group = Group.find(params[:id])
  end
  def edit
    @group = Group.find(params[:id])
  end
  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path #重新連結到首頁
    else
      render:new
    end
  end
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path, notice: "Update Success"
    else
      render:edit
    end
  end
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:alert] = "Group deleted"
    redirect_to groups_path
  end

 private

 def group_params
   params.require(:group).permit(:title, :description)
 end
end
