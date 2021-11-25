class GroupRelationship < ApplicationRecord
  belongs_to :group #belongs_to 属于
  belongs_to :user #belongs_to 属于
end
