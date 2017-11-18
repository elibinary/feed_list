require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it 'set safe code' do
    user = create :user

    # user.send(:ensure_user_key)
    expect(user.user_key.present?).to be_truthy
  end

  it 'fetch project ids for team' do
    user = create :user
    team = create :team, user: user
    project1 = create :project, user: user, team: team
    project2 = create :project, user: user, team: team
    project3 = create :project, user: user, team: team

    user_a = create :user
    create :user_team, user: user_a, team: team
    create :user_project, user: user_a, project: project1
    create :user_project, user: user_a, project: project3
    team.reload
    user.reload
    res = user_a.team_projects(team)
    expect(res).to eq([project1.id, project3.id])
  end
end
