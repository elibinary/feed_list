require 'rails_helper'

RSpec.describe Project, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'create events when create' do
    user = create :user
    team = create :team, user: user
    project = create :project, user: user, team: team

    expect(project.events.count).to eq(1)
    expect(project.events.first.team_id).to eq(team.id)
  end
end
