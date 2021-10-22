class Group < ActiveRecord::Base
belongs_to :user
 validates :title, presence: true #標題限制 空白表單無法儲存
end
