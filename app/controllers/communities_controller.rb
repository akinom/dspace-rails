class CommunitiesController < ApplicationController
  before_action :set_obj, only: [:show]

  # GET /communities
  def top
    # application controller set common gets the top communities
    # ==> nothing to do here
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
