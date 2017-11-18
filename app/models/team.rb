class Team < ApplicationRecord
  include BuildSafeCode
  include EventHandler

  has_many :user_teams
  has_many :events, as: :eventable

  belongs_to :user

  before_save :ensure_safe_code
  # after_commit :record_event, on: :create

  def as_event_json
    {
      type: 'team',
      id: safe_code,
      name: name
    }
  end

  def clear_team_cache
    Rails.cache.delete("team:#{id}:members")
  end

  def members
    Rails.cache.fetch("team:#{id}:members") do
      user_teams.pluck(:user_id).push(user_id)
    end
  end
end
