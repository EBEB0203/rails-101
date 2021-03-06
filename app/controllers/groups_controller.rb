class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :join, :quit, :update, :destroy] #authenticate_user!是 devise 提供的内建功能。
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
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5) #新曾筆數>5切換分頁顯示
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      current_user.join!(@group)
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
    def join
     @group = Group.find(params[:id]) #current_user 要設定 join 跟quit上去
      if !current_user.is_member_of?(@group)
        current_user.join!(@group)
        flash[:notice] = "加入本讨论版成功！"
      else
        flash[:warning] = "你已经是本讨论版成员了！"
      end

      redirect_to group_path(@group)
    end

    def quit
      @group = Group.find(params[:id])

      if current_user.is_member_of?(@group)
        current_user.quit!(@group)
        flash[:alert] = "已退出本讨论版！"
      else
        flash[:warning] = "你不是本讨论版成员，怎么退出 XD"
      end

      redirect_to group_path(@group)
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
