class ItemsController < ApplicationController
  before_action :set_obj, only: [:show]

  # GET /colections/1
  def show
    @bitstreams = @dspace_obj.bitstreams({})
  end

  private
    def set_obj
    # Use callbacks to share common setup or constraints between actions.
      set_dspace_obj(DSpace::Rest::Item, ['metadata', 'parentCollectionList', 'parentCommunityList'])
    end

end
