require 'rails_helper'

RSpec.describe Team, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'set safe code' do
    user = create :user
    team = create :team, user: user

    # user.send(:ensure_user_key)
    expect(team.safe_code.present?).to be_truthy
  end

  it 'return event infos' do
    user = create :user
    team = create :team, user: user

    res = team.as_event_json
    expect(res[:type]).to eq('team')
    expect(res[:id]).to eq(team.safe_code)
  end
end
