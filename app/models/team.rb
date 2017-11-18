class Team < ApplicationRecord
  include BuildSafeCode
  include EventHandler

  has_many :user_teams
  has_many :events, as: :eventable
  has_many :projects

  belongs_to :user

  before_save :ensure_safe_code
  after_commit :into_user_team, :clear_member_cache, on: :create

  def as_event_json
    {
      type: 'team',
      id: safe_code,
      name: name
    }
  end

  def clear_member_cache
    Rails.cache.delete("team:#{id}:members")
  end

  def clear_projects_cache
    Rails.cache.delete("team:#{id}:project_ids")
  end

  def members
    Rails.cache.fetch("team:#{id}:members") do
      user_teams.pluck(:user_id).push(user_id)
    end
  end

  def project_ids
    Rails.cache.fetch("team:#{id}:project_ids") do
      projects.pluck(:id)
    end
  end

  private

  def into_user_team
    UserTeam.create(user_id: user_id, team_id: id, power: 'administrator')
  end
end
