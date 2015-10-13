module Sitemap
  class CollectionsOverwrite

    def show(controller)
      items = controller.get(:dspace_obj).items({limit: 1000 })
      controller.set(:items, items)
    end
  end

end