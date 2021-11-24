class Post < ApplicationRecord
  belongs_to :user  #belongs_to 属于
  belongs_to :group #belongs_to 属于
  validates :content, presence: true #標題不得為空
  scope :recent, -> { order("created_at DESC")} #執行recent時會拿到ActiveRecord::Relation的物件
end
