class Post < ApplicationRecord
  belongs_to :user  #belongs_to 属于
  belongs_to :group #belongs_to 属于
  validates :content, presence: true #標題不得為空
end
