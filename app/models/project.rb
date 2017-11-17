class Project < ApplicationRecord
  include BuildSafeCode

  has_many :user_projects
  has_many :events, as: :eventable

  belongs_to :user

  before_save :ensure_safe_code

  def as_event_json
    {
      type: 'project',
      id: safe_code,
      name: name
    }
  end
end
