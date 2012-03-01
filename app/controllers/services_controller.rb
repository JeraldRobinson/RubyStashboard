class ServicesController < ApplicationController
  before_filter :signed_in_user
  before_filter :get_service, :only => [:show, :edit, :update, :destroy]

  def index
    @services=current_user.services
  end

  def new
    @service = current_user.services.new
  end
  
  def show
    @service = Service.find(params[:id])
    @events=Service.find(params[:id]).events
    render service_events_path
  end
  
  def create
    @service = current_user.services.new(params[:service])
    if @service.save
      flash[:success] = "Service Saved"
      redirect_to services_path
    else
      render :new
    end
  end

  def destroy
  end

  private
  
  def get_service
    begin
      @service = current_user.services.build(params[:service])
    rescue ActiveRecord::RecordNotFound
      render file: "public/404.html", status: 404
    end
  end
end
