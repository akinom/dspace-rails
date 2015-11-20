module ApplicationHelper

  def body_classes
    objs_handles = @c_dspace_obj_parents.collect { |p| p.handle}
    objs_handles << @c_dspace_obj.handle if @c_dspace_obj and @c_dspace_obj.handle
    css_classes = objs_handles.collect { |c| "hdl-" + c.gsub('/', '-') }
    "#{@c_layout} #{params[:controller].gsub('/', '-')} #{params[:action]} #{css_classes.join(' ')}"
  end

  def md_to_class(metadata)
    metadata.gsub('.', '-')
  end

  def debug_inspect(value)
    if value.respond_to? :collect then
      vals = value.collect { |e| content_tag(:li, h(e.inspect)) }
      return content_tag :ul, vals.join("\n").html_safe unless vals.empty?
    end
    return value.inspect unless value.nil?
    return "nil"
  end
end
