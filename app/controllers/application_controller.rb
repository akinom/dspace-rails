class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_common

  def about
    display
  end

  def todo
    display
  end

  protected
  def set_dspace_obj(klass, expand = [])
    # expand nothing
    @dspace_obj = klass.find_by_id(params[:id], expand)
    @dspace_obj_parents = []
    if (@dspace_obj) then
      # TODO: this should be part of the dspace-rest gem
      # and parents should be a list of Collectcon, community objects
      parents = []
      list = @dspace_obj.attributes['parentCollectionList'];
      if (!list.nil? and list.size > 0) then
        parents = list
      end
      if @dspace_obj.attributes['parentCommunity'] then
        parents << @dspace_obj.attributes['parentCommunity']
      end
      list = @dspace_obj.attributes['parentCommunityList'];
      if (!list.nil? and list.size > 0) then
        parents = parents + @dspace_obj.attributes['parentCommunityList']
      end
      @dspace_obj_parents = parents;
    end
    return @dspace_obj
  end


  def set_common
    @app_name = "DspaceRails"
    @contact_email = "contact@myplace.edu"
    @top_communities = DSpace::Rest::Community.topCommuities(:linit => 10000)
    @dspace_obj_parents  = [] unless @dspace_obj_parents
    @layout = params['layout'] || 'application'
  end

end
