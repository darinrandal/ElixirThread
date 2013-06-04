class EventsController < ApplicationController
  before_action :get_events, only: [:show, :ajax]

  def index
    @events = Event.all(:order => 'id DESC')
  end

  def show
    render 'index'
  end

  def ajax
  	render :layout => false
  end

 private
   def get_events
   	 @events = Event.where('user_id1 = :id OR user_id2 = :id', {:id => params[:id]}).order('id DESC')
   end
end
