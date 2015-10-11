class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :do_always

  def about
    display
  end

  def todo
    display
  end

  protected
  def set_dspace_obj(klass, expand = [])
    # expand nothing
    @dspace_obj = klass.find_by_id(params[:id], expand)
    @dspace_obj_parents = []
    if (@dspace_obj) then
      # TODO: this should be part of the dspace-rest gem
      # and parents should be a list of Collectcon, community objects
      parents = []
      list = @dspace_obj.attributes['parentCollectionList'];
      if (!list.nil? and list.size > 0) then
        parents = list
      end
      if @dspace_obj.attributes['parentCommunity'] then
        parents << @dspace_obj.attributes['parentCommunity']
      end
      list = @dspace_obj.attributes['parentCommunityList'];
      if (!list.nil? and list.size > 0) then
        parents = parents + @dspace_obj.attributes['parentCommunityList']
      end
      @dspace_obj_parents = parents;
    end
    return @dspace_obj
  end

  def do_always
    @app_name = "DspaceRails"
    @contact_email = "contact@myplace.edu"

    # if dspace_obj_parents noy set by set_dspace_obj  default to []
    @dspace_obj_parents = [] unless @dspace_obj_parents

    @layout = params['layout']
    @overwriter = find_overwriter(self.class)
    do_overwrite(:do_always)

  end

  # app/controllers/application_controller.rb
  def default_url_options(options = {})
    {layout: @layout}.merge options
  end

  def display(options = {})
    opts = {layout: params['layout'],
            controller: params['controller'],
            action: params['action']}.merge(options)
     # use template_exists?
     overwrite = "#{@layout}/#{opts[:controller]}/#{opts[:action]}"
     if (template_exists?(overwrite)) then
       opts = {template: overwrite}.merge(opts)
     end
    render(opts)
  end

  public
  def set(sym, value)
    eval "@#{sym.to_s} = value"
  end

  def get(sym)
    eval "@#{sym.to_s}"
  end

  protected
  def do_overwrite(method)
    if (@overwriter and @overwriter.respond_to?(method)) then
      return @overwriter.send method, self
    end
    return nil
  end

  public
  def find_overwriter(klass)
    puts "find_overwriter #{klass}"
    if (klass.name.include?('::')) then
      return find_overwriter(ApplicationController)
    end
    begin
      overwriterklass = "#{@layout.camelcase}::#{klass.to_s.chomp('Controller')}Overwrite"
      @overwriter = Class.const_get(overwriterklass).new
      return @overwriter
    rescue
      if (klass != ApplicationController) then
        parent = klass.ancestors[1]
        return find_overwriter(parent)
      else
        return nil
      end
    end
  end
end
