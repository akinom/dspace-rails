  class CollectionsController

    def default_show
      #todo figure out auto loading of item model
      Item
      @items = @dspace_obj.items({limit: 10, :expand => 'metadata'})
    end

  end

