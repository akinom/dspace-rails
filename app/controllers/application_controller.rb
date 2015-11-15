class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :do_always

  def handle
    @handle = params[:part1] + "/" + params[:part2];
    render :action => 'todo'
  end

  def about
    do_overwrite(:about)
  end

  def todo
  end

  def set_dspace_obj(klass, expand = [])
    # expand nothing
    @dspace_obj = klass.find_by_id(params[:id], expand)
    @dspace_obj_parents = @dspace_obj.parent_list
    @dspace_obj
  end

  def do_always

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

  alias_method :plain_render, :render

  def render(*args, &block)
    unless @config
      contexts = [nil]
      contexts << @dspace_obj_parents.collect { |d| d.handle }
      contexts << @dspace_obj.handle if @dspace_obj
      contexts << current_user.email if current_user
      @config = ConfigValue.resolve(contexts)
    end

    args[0] = {} unless args[0]
    args[0][:layout] = args[0][:layout] || params['layout']
    template = args[0][:template]
    if (template.nil?) then
      controller = args[0][:controller] || params['controller']
      action = args[0][:action] || params['action']
      overwrite = "#{args[0][:layout]}/#{controller}/#{action}"
      if (template_exists?(overwrite)) then
        args[0][:template] = overwrite
      end
    end

    plain_render(*args, &block)
  end

    public
    def set(sym, value)
      self.instance_variable_set("@" + sym.to_s, value)
    end

    def get(sym)
      self.instance_variable_get("@" + sym.to_s)
    end

    private
    def find_overwriter(klass)
      return nil if klass.class != Class;
      over = nil
      begin
        overwriterklass = "#{@layout.camelcase}::#{klass.to_s.chomp('Controller')}Overwrite"
        over = Class.const_get(overwriterklass).new
      rescue Exception => e
        over = find_overwriter(klass.ancestors[1])
      end
      over
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
