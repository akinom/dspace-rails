class CollectionsController < ApplicationController
  before_action :set_obj, only: [:show]
  before_action :call_layout_method

  # GET /colections/1
  def show
    #TODO - a hack to load the Item model
    Item
    @items = @dspace_obj.items({limit: 10})  unless @items
  end


  private
    def set_obj
      set_dspace_obj(Collection, ['parentCommunityList'])
    end

end
