class SearchsController < ApplicationController
  def create
    session[:query] = params[:query]
    redirect_to searchs_path
  end

  def index
    query = session[:query] || ""
    @searchs = Event.where("title like '%" + query + "%'").paginate(page: params[:page], per_page: 5)
  end
end
