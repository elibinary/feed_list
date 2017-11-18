require 'rails_helper'

RSpec.describe Todo, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'return event infos' do
    user = create :user
    team = create :team, user: user
    project = create :project, user: user, team: team
    todo = create :todo, user: user, project: project, content: 'xxx'

    res = todo.as_event_json
    expect(res[:type]).to eq('todo')
    expect(res[:id]).to eq(todo.safe_code)
  end

  it 'sham delete' do
    user = create :user
    team = create :team, user: user
    project = create :project, user: user, team: team
    todo = create :todo, user: user, project: project, content: 'xxx'
    todo.sham_delete(user)

    event = Event.where(eventable: todo).last
    expect(todo.deleted).to eq(true)
    expect(event.content).to eq('删除了任务')
    expect(event.user_id).to eq(user.id)
  end

  it 'finished' do
    user = create :user
    team = create :team, user: user
    project = create :project, user: user, team: team
    todo = create :todo, user: user, project: project, content: 'xxx'
    todo.finished(user)

    event = Event.where(eventable: todo).last
    expect(todo.state).to eq('finished')
    expect(event.content).to eq('完成了任务')
    expect(event.user_id).to eq(user.id)
  end

  it 'assign' do
    user = create :user
    team = create :team, user: user
    project = create :project, user: user, team: team
    todo = create :todo, user: user, project: project, content: 'xxx'
    todo.assign(user, user)

    event = Event.where(eventable: todo).last
    expect(todo.executor_id).to eq(user.id)
    expect(event.content).to eq("给 #{user.nickname} 指派了任务")
    expect(event.user_id).to eq(user.id)
  end

  it 'assign to other' do
    user = create :user
    other = create :user
    team = create :team, user: user
    project = create :project, user: user, team: team
    todo = create :todo, user: user, project: project, content: 'xxx', executor_id: user.id
    todo.assign(user, other)

    event = Event.where(eventable: todo).last
    expect(todo.executor_id).to eq(other.id)
    expect(event.content).to eq("把 #{user.nickname} 的任务指派给 #{other.nickname}")
    expect(event.user_id).to eq(user.id)
  end

  it 'set deadline' do
    user = create :user
    team = create :team, user: user
    project = create :project, user: user, team: team
    todo = create :todo, user: user, project: project, content: 'xxx'
    other = create :user
    todo.set_deadline(other, Date.today + 3.days)

    event = Event.where(eventable: todo).last
    expect(todo.deadline).to eq(Date.today + 3.days)
    expect(event.content).to eq("将任务完成时间从 没有截止日期 修改为 #{todo.deadline.to_s}")
    expect(event.user_id).to eq(other.id)
  end

  it 'create comment' do
    user = create :user
    team = create :team, user: user
    project = create :project, user: user, team: team
    todo = create :todo, user: user, project: project, content: 'xxx'
    other = create :user
    res = todo.send_comment(other, '少时诵诗书')

    event = Event.where(eventable: res).last
    expect(event.content).to eq('回复了任务')
    expect(event.user_id).to eq(other.id)
  end
end
