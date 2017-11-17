class Api::V1::EventsController < Api::BaseController

  # GET /events
  def index
    team = Team.find_by(safe_code: params[:team], user_id: current_user.id)
    unless team
      render_fail('团队不存在')
      return
    end

    events = team.events.includes(:user, :project, :eventable).order(id: :desc).page(params[:page] || 1).per(params[:per] || 50)
    render json: { events: events.map(&:as_show_json) }
  end
end