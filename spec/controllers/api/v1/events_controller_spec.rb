require 'rails_helper'

RSpec.describe Api::V1::EventsController do
  describe 'GET index' do
    it 'with bad team' do
      user = create :user
      team = create :team, user: user
      token = FeedListToken.encode(openid: user.user_key)

      get :index, params: { feed_token: token, team: '111', format: :json }
      res = JSON.parse(response.body)
      expect(res['success']).to eq(0)
    end

    it 'return events list' do
      user = create :user
      team = create :team, user: user
      # event = create :event, user: user, team: team, eventable: team, project_id: 0, content: '创建了团队'

      token = FeedListToken.encode(openid: user.user_key)

      get :index, params: { feed_token: token, team: team.safe_code, format: :json }
      res = JSON.parse(response.body)
      expect(res['events'].count).to eq(1)
      expect(res['events'].first['user_name']).to eq(user.nickname)
    end
  end
end