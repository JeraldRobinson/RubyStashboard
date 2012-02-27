class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  helper_method :current_user

  rescue_from Exception, :with => :render_error
  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  rescue_from ActionController::RoutingError, :with => :render_not_found
  rescue_from ActionController::UnknownController, :with => :render_not_found
  rescue_from ActionController::UnknownAction, :with => :render_not_found
  
  protected

  def render_not_found
    flash[:error] = "User not found"
    render file: "public/404.html", status: 404
  end
  
  def render_error
    flash[:error] = "System Error"
    render file: "public/500.html", status: 500
  end
  
end
