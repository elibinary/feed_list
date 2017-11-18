class Comment < ApplicationRecord
  include EventHandler

  belongs_to :todo
  belongs_to :user

  has_many :events, as: :eventable

  def as_event_json
    todo.as_event_json.merge({ detail_content: content })
  end
end
