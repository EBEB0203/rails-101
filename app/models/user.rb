class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :groups #has_many 拥有很多
  has_many :posts  #has_many 拥有很多
  has_many :group_relationships
  has_many :participated_groups, :through => :group_relationships, :source => :group #through通過 主要建立在多對多關聯資料庫時使用
  def is_member_of?(group)
   participated_groups.include?(group)
  end
  def join!(group) #加入群組
    participated_groups << group
  end
  def quit!(group) #退出群組
    participated_groups.delete(group)
  end
end
