class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :executor, class_name: 'User', foreign_key: 'executor_id'
  belongs_to :project

  has_many :comments
  has_many :events, as: :eventable

  def as_event_json
    {
      type: 'todo',
      id: safe_code,
      name: content
    }
  end
end
