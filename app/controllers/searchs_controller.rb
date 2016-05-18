class SearchsController < ApplicationController
  def create
    session[:query] = params[:query]
    redirect_to searchs_path
  end

  def index
    query_eq = {}
    query_like = ""
    query_value = []
    (session[:query] || "").split.each do |condition|
      key, value = condition.split(":")
      key, value = "title", key unless value
      case key
      when "tag"
        query_eq["tags.name"] = value #only use last one when multiple tag is specified
      when "title", "description", "owner", "location", "hold_at"
        query_like << (query_like.size == 0 ?  "#{key} like ? " : "and #{key} like ? ")
        query_value << "%#{value}%"
      end
    end
    # TODO: now event will lost other tags since using left outer join
    @searchs = Event.includes(:tags).where(query_eq).where(query_like, *query_value).paginate(page: params[:page], per_page: 5)
    @count = @searchs.count
  end
end
