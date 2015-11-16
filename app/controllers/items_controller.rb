class ItemsController < ApplicationController
  before_action :set_obj, only: [:show]
  before_action  :call_layout_method

  # GET /colections/1
  def show
    @bitstreams = @dspace_obj.bitstreams({})
  end

  private
    def set_obj
      set_dspace_obj(Item, ['metadata', 'parentCollectionList', 'parentCommunityList'])
    end

end
