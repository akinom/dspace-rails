class CollectionsController < ApplicationController
  before_action :set_obj, only: [:show]

  # GET /colections/1
  def show
    @items = @dspace_obj.items({})
  end

  private
    def set_obj
    # Use callbacks to share common setup or constraints between actions.
      set_dspace_obj(DSpace::Rest::Collection, ['parentCommunityList'])
    end

end