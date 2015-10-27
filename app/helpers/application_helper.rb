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
end
