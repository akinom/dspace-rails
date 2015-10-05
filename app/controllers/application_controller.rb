class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_common

  def about
  end

  def todo
  end

  protected
  def set_dspace_obj(klass)
    # expand nothing
    @dspace_obj = klass.find_by_id(params[:id], [])
  end

  def set_common
    @app_name = "DspaceRails"
    @contact_email = "contact@myplace.edu"
    @top_communities = DSpace::Rest::Community.topCommuities(:linit => 10000)
  end


end
