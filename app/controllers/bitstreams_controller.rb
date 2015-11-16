class BitstreamsController < ApplicationController
  before_action :set_obj, only: [:show]
  before_action  :call_layout_method

  # GET /bitstreams/1
  def show
    render  :controller => "application", :action => "todo"
  end


  private
    def set_obj
      set_dspace_obj(Bitstream, ['parent'])
    end

end
