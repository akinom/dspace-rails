require 'rails_helper'

RSpec.describe ConfigValue, type: :model do

  before(:context) do
    @type_fix_num  = ConfigType.find_or_create_by(name: 'fixnum') do |type|
      type.klass = Fixnum
    end

    @create_fix_num = {
        :controller => 'ItemsController',
        :layout => "layout",
        :config_type => @type_fix_num,
        :value => "1"
    }
  end

  after(:context) do
    @type_fix_num.destroy
  end

  [:controller, :layout, :context].each do  |key|
    it "create_without_#{key}" do
      @create_fix_num.delete(key)
      ConfigValue.create!(@create_fix_num).inspect
    end
  end

  [:value, :config_type].each do  |key|
    it "create_without_#{key}" do
      @create_fix_num.delete(key)
      expect { ConfigValue.create!(@create_fix_num).inspect}.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end


end
