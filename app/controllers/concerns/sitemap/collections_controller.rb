class CollectionsController
  def sitemap_show
    @items = @dspace_obj.items({limit: 100})
  end
end

