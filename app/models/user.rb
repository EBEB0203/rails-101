class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :groups #has_many 拥有很多
  has_many :posts  #has_many 拥有很多
  has_many :group_relationships
  has_many :participated_groups, :through => :group_relationships, :source => :group #through通過 主要建立在多對多關聯資料庫時使用
end
