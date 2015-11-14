module Default
  class CollectionsOverwrite < ApplicationOverwrite

    def show(controller)
      controller.set(:items, controller.get(:dspace_obj).items({limit: 10, :expand => 'metadata'}))
    end

  end

end