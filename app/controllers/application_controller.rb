class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_common

  protected
  def set_dspace_obj(klass)
    # expand nothing
    @dspace_obj = klass.find_by_id(params[:id], [])
  end

  def set_common
    @topCommunities = DSpace::Rest::Community.topCommuities(:linit => 10000)
  end


end
