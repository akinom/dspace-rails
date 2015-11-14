namespace :config do
  desc "CLI to work with ConfigValues"
  task list: :environment do
    ConfigValue.all().each { |v| puts v.inspect }
  end

  task seed: :environment do
    %w(ContactEmail AppName CollectionDescription).each do |config|
      ConfigType.find_or_create_by(name: config) do |type|
        type.klass = String
      end
    end

    ConfigValue.find_or_create_by(scope: nil, config_type: ConfigType.find_by_name('ContactEmail')) do |val|
      val.value = "contact@university,edu"
    end
    ConfigValue.find_or_create_by(scope: nil, config_type: ConfigType.find_by_name('AppName')) do |val|
      val.value = "RailsSpace"
    end
    ConfigValue.find_or_create_by(scope: nil, config_type: ConfigType.find_by_name('CollectionDescription')) do |val|
      val.value = "";
    end

    descr = ConfigType.find_by_name('CollectionDescription')
    DSpace::Rest::Community.topCommuities(:linit => 10000).each do |com|
      if (com.name[0] <= 'M') then
        value = "Describing this very content with words about #{com.name}"
        val = ConfigValue.find_by(config_type: descr, :scope => com.handle)
        val ||= ConfigValue.new(config_type: descr, :scope => com.handle)
        val.value = value
        val.scope = com.handle
        val.save
      end
    end
  end
end
