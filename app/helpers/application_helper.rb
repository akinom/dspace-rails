module ApplicationHelper

  def body_classes
    objs_handles = @dspace_obj_parents.collect { |p| p.handle}
    objs_handles << @dspace_obj.handle if @dspace_obj and @dspace_obj.handle
    css_classes = objs_handles.collect { |c| "hdl-" + c.gsub('/', '-') }
    "#{@layout} #{params[:controller].gsub('/', '-')} #{params[:action]} #{css_classes.join(' ')}"
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
