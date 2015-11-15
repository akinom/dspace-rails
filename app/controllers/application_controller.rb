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
  end

  def todo
  end

  def set_dspace_obj(klass, expand = [])
    @dspace_obj = klass.find_by_id(params[:id], expand)
    @dspace_obj_parents = @dspace_obj.parent_list
    @dspace_obj
  end

  def do_always
    # if dspace_obj_parents not set by set_dspace_obj  default to []
    @dspace_obj_parents = [] unless @dspace_obj_parents

    @layout = params['layout']
    load_layout_concerns
    call_layout_method :do_always
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


  def call_layout_method(actn = nil)
    mthd = "#{@layout}_#{actn || params['action']}"
    if respond_to? mthd
      puts "> mthd"
      self.send mthd
      puts "< mthd"
    end
  end

  @@tried_layout_explansion = {}

  def load_layout_concerns
    ["application", params['controller']].each do |ctrler|
      file = "#{@layout}/#{ctrler}_controller.rb"
      unless false && @@tried_layout_explansion[file]
        begin
          puts "try #{file}"
          require file
        rescue Exception => e
          puts "no such #{file}"
        end
        @@tried_layout_explansion[file] = true
      end
    end
  end

end
