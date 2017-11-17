class Todo < ApplicationRecord
  include BuildSafeCode
  include EventHandler

  belongs_to :user
  belongs_to :executor, class_name: 'User', foreign_key: 'executor_id', optional: true
  belongs_to :project

  has_many :comments
  has_many :events, as: :eventable

  before_save :ensure_safe_code

  def as_event_json
    {
      type: 'todo',
      id: safe_code,
      name: content
    }
  end
end
