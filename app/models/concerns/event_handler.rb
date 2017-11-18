module EventHandler
  extend ActiveSupport::Concern

  included do |base|
    after_commit :record_event_with_content, on: :create
  end

  def record_event_with_content(content=nil)
    params = case self
               when Team
                 {
                   user: user,
                   eventable: self,
                   team: self,
                   project_id: 0,
                   content: content || '创建了团队'
                 }
               when Project
                 {
                   user: user,
                   eventable: self,
                   team_id: team_id,
                   project: self,
                   content: content || '创建了项目'
                 }
               when Todo
                 {
                   user: user,
                   eventable: self,
                   team_id: project.team_id,
                   project_id: project_id,
                   content: content || '创建了任务'
                 }
               when Comment
                 {
                   user: user,
                   eventable: self,
                   team_id: project.team_id,
                   project_id: project_id,
                   content: content || '回复了任务'
                 }
               else
                 {}
               end

    Event.create(params)
  end
end