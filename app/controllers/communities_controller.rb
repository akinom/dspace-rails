class CommunitiesController < ApplicationController
  before_action :set_obj, only: [:show, :edit, :destroy]
  before_action :authorize!
  before_action  :call_layout_method

  def map_action
    return :read if params['action'] == 'show'
    return :update if params['action'] == 'edit'
    return :delete if params['action'] == 'destroy'
    return nil if params['action'] == 'top'     # nil ==> always authorize
    return params['action']
  end

  def authorize!
    logger.info  "  authorize! #{@c_dspace_obj || DSpace::Rest::Community} #{map_action}"
    begin
      @c_ability.authorize!(@c_dspace_obj || DSpace::Rest::Community, map_action)
    rescue RuntimeError => e
      raise  "Authorzation Exception: " + e.inspect
    end
  end

  # GET /communities
  def top
    @c_top_communities ||= Community.topCommuities(:limit => 10000)
  end

  # GET /communities/1
  def show
    @c_collections = @c_dspace_obj.collections({})
    @c_communities = @c_dspace_obj.communities({})
  end

  # GET /communities/new
  def new
    render  :controller => "application", :action => "todo"
  end

  # GET /communities/1/edit
  def edit
    render  :controller => "application", :action => "todo"
  end

  # DELETE /communities/1
  def destroy
    render  :controller => "application", :action => "todo"
  end


  private
    def set_obj
      # should have parentCommunityList expander
      set_dspace_obj(Community, ['parentCommunity'])
    end

end
