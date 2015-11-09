class ConfigType < ActiveRecord::Base

  validates_presence_of :klass, :name

  validate :check_klass

  def check_klass
    return false unless klass
    if klass.is_a? String then
      begin
        Class.const_get(klass)
      rescue
        errors[:klass] = "#{self.klass} is not a valid class name"
        self.klass = nil
      end
    elsif klass.class == Class then
      self.klass = klass.class.name
    else
      errors[:klass] = "#{klass} is neither s String nor a Class"
      self.klass = nil
    end
    return  self.klass != nil
  end

end
