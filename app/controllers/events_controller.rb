class EventsController < ApplicationController
  before_action :get_events, only: [:show, :ajax]

  def index
    @events = Event.all(:order => 'id DESC')
  end

  def show
    respond_to do |format|
      format.html { render 'index' }
      format.json  { render :json => @events }
    end
  end

 private
   def get_events
   	 @events = Event.where('user_id1 = :id OR user_id2 = :id', {:id => params[:id]}).order('id DESC')
   end
end
