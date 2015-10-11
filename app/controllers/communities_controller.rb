class CommunitiesController < ApplicationController
  before_action :set_obj, only: [:show]

  # GET /communities
  def top
    do_overwrite(:top)
    if (not @top_communities) then
      @top_communities = DSpace::Rest::Community.topCommuities(:linit => 10000)
    end
    display
  end

  # GET /communities/1
  def show
    do_overwrite(:show)
    @collections = @dspace_obj.collections({})
    @communities = @dspace_obj.communities({})
    display
  end

  private
    def set_obj
      # should have parentCommunityList expander
      set_dspace_obj(DSpace::Rest::Community, ['parentCommunity'])
    end

end
