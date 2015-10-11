module Sitemap
  class CommunitiesOverwrite

    def top(controller)
      top_comunities = DSpace::Rest::Community.topCommuities(:linit => 10000)
      # filter out those that should not be indexed
      filtered = top_comunities.select { |c|  c.name[0] < "M" }
      controller.set(:top_communities, filtered)
    end
  end

end