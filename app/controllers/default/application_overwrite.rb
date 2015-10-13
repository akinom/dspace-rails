module Default
  class ApplicationOverwrite
    def do_always(controller)
      controller.set(:explore_communities, DSpace::Rest::Community.topCommuities(:linit => 10000))
    end
  end
end