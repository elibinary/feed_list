class EventsController < ApplicationController

  # GET /events
  def index
    @team = Team.find_by(safe_code: params[:team_id])
    @events = Event.where(team_id: @team.id).order(id: :desc).page(params[:page]).per(10)
    @events_list = @events.map(&:as_show_json)

    respond_to do |format|
      format.html
      format.json { render json: { events: @events_list } }
    end
  end
end