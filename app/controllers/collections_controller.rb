class CollectionsController < ApplicationController
  before_action :set_obj, only: [:show]
  before_action :authorize!
  before_action :call_layout_method

  def map_action
    return :read if params['action'] == 'show'
    return params['action']
  end

  def authorize!
    logger.info  "  authorize! #{@c_dspace_obj || DSpace::Rest::Collection} #{map_action}"
    @c_ability.authorize!(@c_dspace_obj || DSpace::Rest::Collection, map_action)
  end

  # GET /colections/1
  def show
    @c_items = @c_dspace_obj.items({limit: 10})  unless @c_items
  end

  private
    def set_obj
      set_dspace_obj(Collection, ['parentCommunityList'])
    end

end
