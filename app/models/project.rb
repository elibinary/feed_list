class Project < ApplicationRecord
  include BuildSafeCode
  include EventHandler

  has_many :user_projects
  has_many :events, as: :eventable

  belongs_to :user
  belongs_to :team

  before_save :ensure_safe_code
  # after_commit :record_event, on: :create

  def as_event_json
    {
      type: 'project',
      id: safe_code,
      name: name
    }
  end

  def clear_project_cache
    Rails.cache.delete("project:#{id}:members")
  end

  def members
    Rails.cache.fetch("project:#{id}:members") do
      user_projects.pluck(:user_id).push(user_id)
    end
  end

end
