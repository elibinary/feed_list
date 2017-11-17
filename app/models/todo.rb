class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :executor, class_name: 'User', foreign_key: 'executor_id'
  belongs_to :project

  has_many :comments
end
