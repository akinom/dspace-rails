class ConfigValue < ActiveRecord::Base
  belongs_to :config_type

  validates_presence_of :config_type
  validate :value_valid?, :controller_valid?

  def controller_valid?
    return true if controller.nil?
    begin
      controller.constantize
      return true
    rescue
      errors.add :controller, "#{controller} is not a valid controller class name"
      return false
    end
  end


  def value_valid?
    return false if config_type.nil?
    klass = config_type.type
    if not value.nil?
      obj = YAML.load(value)
      return true if obj.is_a? klass
      if obj.class == Hash then
        inst = klass.new(obj)
        return true
      end
    end
    errors.add :value, "'#{value}' is not a valid #{klass} instance/value"
    return false;
  end

end
