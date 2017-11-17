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

  private

  # def record_event(act='create')
  #   content = '创建了项目'
  #   Event.create(user: user, eventable: self, team: team, project: self, content: content)
  # end
end
