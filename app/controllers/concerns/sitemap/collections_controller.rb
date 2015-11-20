class CollectionsController
  def sitemap_show
    @c_items = @c_dspace_obj.items({limit: 100})
  end
end

