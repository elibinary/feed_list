module EventHandler
  extend ActiveSupport::Concern

  included do |base|
    after_commit :record_event_with_content, on: :create
  end

  def record_event_with_content(content=nil, act_user=nil)
    params = case self
               when Team
                 {
                   user: act_user || user,
                   eventable: self,
                   team: self,
                   project_id: 0,
                   content: content || '创建了团队'
                 }
               when Project
                 {
                   user: act_user || user,
                   eventable: self,
                   team_id: team_id,
                   project: self,
                   content: content || '创建了项目'
                 }
               when Todo
                 {
                   user: act_user || user,
                   eventable: self,
                   team_id: project.team_id,
                   project_id: project_id,
                   content: content || '创建了任务'
                 }
               when Comment
                 {
                   user: act_user || user,
                   eventable: self,
                   team_id: todo.project.team_id,
                   project_id: todo.project_id,
                   content: content || '回复了任务'
                 }
               else
                 {}
               end

    Event.create(params)
  end
end