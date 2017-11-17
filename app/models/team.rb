class Team < ApplicationRecord
  include BuildSafeCode

  has_many :user_teams
  has_many :events, as: :eventable

  belongs_to :user

  before_save :ensure_safe_code
  after_commit :record_event, on: :create

  def as_event_json
    {
      type: 'team',
      id: safe_code,
      name: name
    }
  end

  private

  def record_event(act='create')
    content = '创建了团队'
    Event.create(user: user, eventable: self, team: self, project_id: 0, content: content)
  end
end
