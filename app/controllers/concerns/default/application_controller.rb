class ApplicationController
puts "loading #{__FILE__}"
  def default_do_always
    @explore_communities = Community.topCommuities(:linit => 10000);
  end

end