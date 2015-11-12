require 'rails_helper'

RSpec.describe ConfigValue, type: :model do

  before(:context) do
    @type_fix_num = ConfigType.find_or_create_by(name: 'fixnum') do |type|
      type.klass = Fixnum
    end

    @type_any_obj = ConfigType.find_or_create_by(name: 'anyobj') do |type|
      type.klass = Object
    end

    @create_fix_num = {
        :controller => 'ItemsController',
        :layout => "layout",
        :config_type => @type_fix_num,
        :value => 1
    }

    @create_any_obj = {
        :controller => 'ApplicationController',
        :layout => "library",
        :config_type => @type_any_obj
    }
  end

  after(:context) do
    @type_fix_num.destroy
    @type_any_obj.destroy
  end

  [:remove_none, :controller, :layout, :context].each do |key|
    it "create_fixnum_without_#{key}" do
      @hsh = @create_fix_num.clone
      @hsh.delete(key)
      c = ConfigValue.create!(@hsh)
      expect(c.value).to eq(@hsh[:value])
    end
  end

  [10, "string", :symbol, {h: 'hash'}, [1, 2, 3, 4]].each do |value|
    it "create_any_obj_with_value=#{value}" do
      c = ConfigValue.create!({:value => value}.merge(@create_any_obj))
      expect(c.value).to eq(value)
    end
  end

  [:value, :config_type].each do |key|
    it "create_without_#{key}" do
      @hsh = @create_fix_num.clone
      @hsh.delete(key)
      c = ConfigValue.new(@hsh)
      expect(c.valid?).to eq(false)
      expect(c.errors.messages[key == :value ? :yaml_value : key]).to_not be_nil
    end
  end

  it "create_with_bad_controller" do
    c = ConfigValue.new(@create_fix_num.merge(:controller => 'BadController'))
    expect(c.valid?).to eq(false)
    expect(c.errors.messages[:controller]).to_not be_nil
  end

  it 'resolve' do
    [{:controller => 'ApplicationController', :layout => 'library', :context => nil, :value => 'layout,controller' },
    {:controller => 'ApplicationController', :context => nil, :value => '*,controller'},
    {:layout => 'library', :context => nil, :value => 'library,* '},
    {:value => '*,*'}].each do |hsh|
      ConfigValue.create( {:config_type => @type_any_obj }.merge(hsh))
    end

    ConfigValue.destroy_all
  end

end
