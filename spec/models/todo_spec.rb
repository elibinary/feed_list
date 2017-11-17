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
end
