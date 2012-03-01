class EventsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user
  before_filter :get_service
 
  def index
    @events=@service.events
  end
  
  def new
    @event=@service.events.new()
  end
  
  def create
    @event=@service.events.new(params[:event])
    if @event.save
      flash[:success] = "Event Saved"
      redirect_to service_events_path
    else
      render :new
    end
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def destroy
      @event = Event.find(params[:id] )
      redirect_to(@event) and return if params[:cancel]
      @event.destroy
      respond_to do |format|
          format.json { render :json => @event }
      end
  end
  
  def get_service
    begin
      @service = Service.find(params[:service_id])
    rescue ActiveRecord::RecordNotFound
      render file: "public/404.html", status: 404
    end
  end
  
  private

  def correct_user
    @services = current_user.services.find_by_id(params[:service_id])
    redirect_to services_path unless ! @services.nil? or current_user.admin?
  end
end
