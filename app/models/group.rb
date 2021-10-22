class Group < ActiveRecord::Base
 belongs_to :user #belongs_to 属于
 has_many :posts  #has_many 拥有很多
 validates :title, presence: true #標題限制 空白表單無法儲存
end
