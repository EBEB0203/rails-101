class Group < ActiveRecord::Base
 belongs_to :user #belongs_to 属于
 has_many :posts  #has_many 拥有很多
 validates :title, presence: true #標題限制 空白表單無法儲存
 has_many :group_relationships
 has_many :members, through: :group_relationships, source: :user #through通過 主要建立在多對多關聯資料庫時使用
end
