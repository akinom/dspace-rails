module ApplicationHelper

  def body_classes
    objs_handles = @dspace_obj_parents.collect { |p| p.handle}
    objs_handles << @dspace_obj.handle if @dspace_obj
    css_classes = objs_handles.collect { |c| c.gsub('/', '-') }
    "#{@layout} #{params[:controller].gsub('/', '-')} #{params[:action]} #{css_classes.join(' ')}"
  end
end
