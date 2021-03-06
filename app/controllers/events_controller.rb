class EventsController < ApplicationController
  def index
    @events = Event.all(:order => 'id DESC')
  end

  def show
    @events = Event.where('user_id1 = :id OR user_id2 = :id', {:id => params[:id]}).order('id DESC')
    if request.xhr?
    	render 'index', :layout => false
    else
    	render 'index'
    end
  end
end
