class BitstreamsController < ApplicationController
  before_action :set_obj, only: [:show]

  # GET /bitstreams/1
  def show
    render  :controller => "application", :action => "todo"
  end


  private
    def set_obj
      set_dspace_obj(DSpace::Rest::Bitstream, ['parent'])
    end

end
