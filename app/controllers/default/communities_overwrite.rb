module Default
  class CommunitiesOverwrite < ApplicationOverwrite

    def top(controller)
      controller.set(:top_communities, controller.get(:explore_communities))
    end

  end

end