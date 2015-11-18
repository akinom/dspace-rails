class ApplicationController
  def default_do_always
    @explore_communities = Community.topCommuities(:linit => 10000);
  end
end
