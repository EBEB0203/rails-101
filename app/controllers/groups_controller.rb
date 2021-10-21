class GroupsController < ApplicationController
  def index
  @groups = Group.all #撈出所有的群
  end
  def new
  @groups = Group.new
  end
  def show
  @group = Group.find(params[:id])
  end
  def edit
  @group = Group.find(params[:id])
  end
  def create
  @group = Group.new(group_params)
  @group.save

    redirect_to groups_path, notice: "儲存成功!"
  end
  def update
  @group = Group.find(params[:id])
  @group.update(group_params)

   redirect_to groups_path, notice: "Update Success"
 end
 private

 def group_params
   params.require(:group).permit(:title, :description)
 end
end
