class Event < ApplicationRecord
  belongs_to :eventable, polymorphic: true
  belongs_to :user
  belongs_to :team
  belongs_to :project, optional: true

  def as_show_json
    {
      user_name: user.nickname,
      user_key: user.user_key,
      avatar_url: user.avatar_url,
      content: target_and_content,
      superior: superior_info,
      created_at: created_at
    }
  end

  def target_and_content
    eventable.as_event_json.merge({ content: content })
  end

  def superior_info
    superior, type = project.present? ? [project, 'project'] : [team, 'team']
    {
      type: type,
      id: superior.safe_code,
      name: superior.name
    }
  end
end
