class SearchsController < ApplicationController
  def create
    @events = []
    if request.post? then
      query = params[:query]
      @events = Event.where("title like '%" + query + "%'")
    end
  end
end
