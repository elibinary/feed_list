class EventsController < ApplicationController

  # GET /events
  def index
    @team = Team.find_by(safe_code: params[:team_id])
    @events = Event.where(team_id: @team.id).order(id: :desc).page(params[:page]).per(10)
    @events_list = @events.map(&:as_show_json)

    current_date = (Date.parse(params[:current_date]) rescue nil)
    current_pj_id = params[:current_pj_id].to_i
    list_html = ''
    @events_list.each do |event|
      if current_date.blank? || event[:created_at].to_date != current_date
        current_date = event[:created_at].to_date
        current_pj_id = event[:superior][:id]
        span = <<-EOF
          <h3>日期：#{current_date}</h3>
          <hr>
          <h4>
            <a href="#">#{event[:superior][:name]}</a>
          </h4>
          <hr>
        EOF
        list_html << span
      elsif event[:superior][:id] != current_pj_id
        current_pj_id = event[:superior][:id]
        span = <<-EOF
          <h4>
            <a href="#">#{event[:superior][:name]}</a>
          </h4>
          <hr>
        EOF
        list_html << span
      end

      span = <<-EOF
        <div class="media">
          <div class="media-left">
            <a href="#">
              <img class="media-object" src="#{event[:avatar_url]}" alt="" width="64" height="64" style="border: 1px solid blanchedalmond;">
            </a>
          </div>
          <div class="media-body">
            <h4 class="media-heading">
              <a href="#">#{event[:user_name]}</a>
              #{event[:content][:content]}
              :
              <a href="#">#{event[:content][:name]}</a>
            </h4>
            <a href="#">#{event[:content][:detail_content]}</a>
          </div>
        </div>
      EOF
      list_html << span
    end

    respond_to do |format|
      format.html
      format.json { render json: { list_html: list_html, current_date: current_date, current_pj_id: current_pj_id } }
    end
  end
end