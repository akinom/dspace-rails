class CommunitiesController < ApplicationController
  before_action :set_obj, only: [:show]
  before_action  :call_layout_method

  # GET /communities
  def top
    @c_top_communities ||= Community.topCommuities(:linit => 10000)
  end

  # GET /communities/1
  def show
    @c_collections = @c_dspace_obj.collections({})
    @c_communities = @c_dspace_obj.communities({})
  end

  private
    def set_obj
      # should have parentCommunityList expander
      set_dspace_obj(Community, ['parentCommunity'])
    end

end
