class CommunitiesController < ApplicationController
  before_action :set_obj, only: [:show]
  before_action  :call_layout_method

  # GET /communities
  def top
    @top_communities ||= DSpace::Rest::Community.topCommuities(:linit => 10000)
  end

  # GET /communities/1
  def show
    @collections = @dspace_obj.collections({})
    @communities = @dspace_obj.communities({})
  end

  private
    def set_obj
      # should have parentCommunityList expander
      set_dspace_obj(DSpace::Rest::Community, ['parentCommunity'])
    end

end
