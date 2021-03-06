class ConfigValue < ActiveRecord::Base
  belongs_to :config_type

  validates_presence_of :config_type
  validate :value_valid?

  def initialize(hsh = {})
    v = hsh[:value]
    hsh[:yaml_value] = v.to_yaml unless v.nil?
    super(hsh)
  end

  def value
    return nil unless yaml_value
    @value ||= YAML.load(yaml_value)
  end

  def value=(v)
    @value = v
    self.yaml_value = v.to_yaml
  end

  def value_valid?
    return false if config_type.nil?
    klass = config_type.type
    if not yaml_value.nil?
      obj = YAML.load(yaml_value)
      return true if obj.is_a? klass
      if obj.class == Hash then
        inst = klass.new(obj)
        return true
      end
    end
    errors.add :yaml_value, "'#{yaml_value}' is not valid yaml for #{klass}"
    return false;
  end

  def inspect
    s = "#<#{self.class}"
    s += " id:#{id}" if id
    s += " #{config_type.id}:#{config_type.name}" if config_type
    s += " val=#{value}" if value
    s += " scope=#{scope}" if scope
    s += ">"
    return s
  end

  def self.resolve(actualScopes)
    hsh = {}
    actualScopes.each do |s|
      matches =  ConfigValue.where(:scope => s).each do  |v|
        key = v.config_type.name.underscore.to_sym
        if v.value.is_a? Hash then
          hsh[key] ||= {}
          hsh[key] = hsh[key].merge(v.value)
        else
          hsh[key] = v.value
        end
      end
    end
    return hsh
  end

  end
