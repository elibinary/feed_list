class Api::V1::EventsController < Api::BaseController
  before_action :check_params, only: [:index]

  # GET /events
  def index
    events_temp = Event.where(team_id: @team.id)
    if @project
      events_temp.includes(:user, :eventable).where(project_id: @project)
    elsif @user
      events_temp.includes(:project, :eventable).where(user_id: @user.id)
    else
      events_temp.includes(:user, :project, :eventable)
    end

    events = events_temp.order(id: :desc).page(params[:page] || 1).per(params[:per] || 50)
    render json: { events: events.map(&:as_show_json) }
  end

  private

  def check_params
    @team = Team.find_by(safe_code: params[:team])
    unless @team
      render_fail('团队不存在')
      return
    end

    unless @team.members.include?(current_user.id)
      render_fail('没有权限')
      return
    end

    if params[:project]
      @project = Project.find_by(safe_code: params[:project])
      unless @project && @project.members.include?(current_user.id)
        render_fail('项目不存在')
        return
      end
    end

    if params[:user_key]
      @user = User.find_by(user_key: params[:user_key])
    end
  end
end