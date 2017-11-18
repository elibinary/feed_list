class Todo < ApplicationRecord
  include BuildSafeCode
  include EventHandler

  extend Enumerize

  belongs_to :user
  belongs_to :executor, class_name: 'User', foreign_key: 'executor_id', optional: true
  belongs_to :project

  has_many :comments
  has_many :events, as: :eventable

  enumerize :state, in: { init: 1, finished: 2 }, default: :init, scope: true

  before_save :ensure_safe_code

  def as_event_json
    {
      type: 'todo',
      id: safe_code,
      name: content
    }
  end

  def sham_delete(act_user)
    update(deleted: true)
    record_event_with_content('删除了任务', act_user)
  end

  def finished(act_user)
    update(state: 'finished')
    record_event_with_content('完成了任务', act_user)
  end

  def assign(act_user, exec_user)
    event_content = executor.present? ? "把 #{executor.nickname} 的任务指派给 #{exec_user.nickname}" : "给 #{exec_user.nickname} 指派了任务"
    update(executor_id: exec_user.id)
    record_event_with_content(event_content, act_user)
  end

  def set_deadline(act_user, date)
    event_content = "将任务完成时间从 #{deadline.present? ? deadline.to_s : '没有截止日期'} 修改为 #{date.to_s}"
    update(deadline: date)
    record_event_with_content(event_content, act_user)
  end

  def send_comment(act_user, ctext)
    comment = Comment.create(user: act_user, todo: self, content: ctext)
  end
end
