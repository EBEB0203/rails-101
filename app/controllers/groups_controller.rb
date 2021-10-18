class GroupsController < ApplicationController
  def index
  @groups = Group.all #撈出所有的群
  end
end
