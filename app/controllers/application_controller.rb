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
      # and parents should be a list of Collectcon, and Community objects
      @dspace_obj_parents = []

      list = @dspace_obj.attributes['parentCollectionList'];
      @dspace_obj_parents = list if  list

      com = @dspace_obj.attributes['parentCommunity']
      @dspace_obj_parents << pcom if com

      list = @dspace_obj.attributes['parentCommunityList'];
      @dspace_obj_parents += list if list and list.size > 0

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

  private
  def find_overwriter(klass)
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

  protected
  def do_overwrite(method)
    if (@overwriter and @overwriter.respond_to?(method)) then
      puts "#{method}: call #{@overwriter.class}.#{method}"
      return @overwriter.send method, self
    end
    puts "#{method}: no overwriter " unless @overwriter
    puts "#{method}: no #{@overwriter.class}.#{method} " if @overwriter
    return nil
  end

 end
