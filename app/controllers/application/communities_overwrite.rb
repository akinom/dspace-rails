module Application
  class CommunitiesOverwrite < ApplicationOverwrite

    def top(controller)
      controller.set(:top_communities, controller.get(:menu_top_communities))
    end

  end

end