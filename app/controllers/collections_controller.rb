class CollectionsController < ApplicationController
  before_action :set_obj, only: [:show]

  # GET /colections/1
  def show
    #TODO - a hack to load the Item model
    Item
    do_overwrite(:show)
    @items = @dspace_obj.items({limit: 10})  unless @items
  end


  private
    def set_obj
      set_dspace_obj(DSpace::Rest::Collection, ['parentCommunityList'])
    end

end
