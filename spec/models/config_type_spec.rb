require 'rails_helper'

RSpec.describe ConfigType, type: :model do
  it :create_with_klass_string_and_name do
    ConfigType.create!(:klass => 'String', :name => "a string")
    ConfigType.create!(:klass => String, :name => "another string")
  end

  it :create_without_klass do
    c = ConfigType.new(:name => 'name')
    expect(c.valid?).to be false
  end

  it :create_with_bad_klass_name do
    c = ConfigType.new(:klass => "no_klass", :name => 'name')
    expect { c.klass_valid? }.to raise_error(NameError)
  end

  it :create_with_bad_klass do
    c = ConfigType.new(:klass => 10, :name => 'name')
    expect { c.klass_valid? }.to raise_error(NameError)
  end

  it :create_without_name do
    c = ConfigType.create(:klass => 'String')
    expect(c.valid?).to be false
  end
  it :create_with_nil_name do
    c = ConfigType.create(:klass => 'String', :name => nil)
    expect(c.valid?).to be false
  end

  it :create_with_empty_name do
    c = ConfigType.create(:klass => 'String', :name => "")
    expect(c.valid?).to be false
  end

  it :set_get_klass do
    c = ConfigType.create(:klass => 'Fixnum', :name => "name")
    c.klass= 'String'
    expect(c.klass).to eq('String')
    c.klass= Fixnum
    expect(c.klass).to eq('Fixnum')
  end

  it :save do
    c = ConfigType.new(klass: Fixnum, name: "name")
    c.save!
    cc = ConfigType.find c.id
    expect(c).to eq(cc)
  end
end
