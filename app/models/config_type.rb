class ConfigType < ActiveRecord::Base

  has_many :config_values

  validates_presence_of :klass, :name

  validate :klass_valid?

  def type
    return Class.const_get(klass) if Class.const_defined?(klass)
    return nil
  end

  def klass_valid?
    return false unless klass
    if klass.is_a? String then
      self.klass = nil unless Class.const_defined?(klass)
    elsif klass.class == Class then
      self.klass = klass.class.name
    else
      self.klass = nil
    end
    errors.add :klass, "#{klass} is not a Class nor a Class Name" unless self.klass
    not self.klass.nil?
  end

end
