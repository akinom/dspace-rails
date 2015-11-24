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

  # -----------------------------------------
  # methods to be called by derived controllers
  # -----------------------------------------
  def set_dspace_obj(klass, expand = [])
    @c_dspace_obj = klass.find_by_id(params[:id], expand)
    @c_dspace_obj_parents = @c_dspace_obj.parent_list
    @c_dspace_obj
  end

  def call_layout_method(actn = nil)
    mthd = "#{@c_layout}_#{actn || params['action']}"
    if respond_to? mthd
      logger.info  "  Calling #{mthd}"
      self.send mthd
      logger.debug  "  Returning #{mthd}"
    end
  end

  @@tried_layout_explansion = {}

  def load_layout_concerns
    ["application", params['controller']].each do |ctrler|
      file = "#{@c_layout}/#{ctrler}_controller.rb"
      unless false && @@tried_layout_explansion[file]
        begin
          load file
          logger.info "  loaded #{file}"
        rescue Exception => e
          logger.debug "  no such #{file}"
        end
        @@tried_layout_explansion[file] = true
      end
    end
  end

  # -----------------------------------------
  # methods triggered by all controller actions
  # -----------------------------------------
  def default_url_options(options = {})
    {layout: @c_layout}.merge options
  end

  def do_always
    @c_ability = Ability.new(current_user)

    # if dspace_obj_parents not set by set_dspace_obj  default to []
    @c_dspace_obj_parents = [] unless @c_dspace_obj_parents

    @c_layout = params['layout']
    load_layout_concerns
    call_layout_method :do_always
  end


  alias_method :plain_render, :render

  def render(*args, &block)
    resolve_configs

    # see whether there is a layout specific template for this
    args[0] = {} unless args[0]
    unless args[0].class == Symbol
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
    end

    plain_render(*args, &block)
  end

  def resolve_configs
    unless @c_config
      contexts = [nil]
      contexts << @c_dspace_obj_parents.collect { |d| d.handle }
      contexts << @c_dspace_obj.handle if @c_dspace_obj
      contexts << current_user.email if current_user
      @c_config = ConfigValue.resolve(contexts)
    end
  end


end
