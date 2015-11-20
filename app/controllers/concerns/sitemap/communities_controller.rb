class CommunitiesController

  def sitemap_top
    top_comunities = Community.topCommuities(:linit => 10000)
    # filter out those that should not be indexed
    @c_top_communities = top_comunities.select { |c| c.name[0] < "M" }
  end

end

