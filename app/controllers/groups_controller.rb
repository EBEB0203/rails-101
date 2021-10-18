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
  def create
  @group = Group.new(group_params)
  @group.save

    redirect_to groups_path
 end

 private

 def group_params
   params.require(:group).permit(:title, :description)
 end
end