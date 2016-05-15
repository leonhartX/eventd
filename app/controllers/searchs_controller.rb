class SearchsController < ApplicationController
  def create
    @events = Event.where("title like '%" + params[:query] + "%'")
  end
end
