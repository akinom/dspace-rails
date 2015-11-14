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
    ConfigValue.find_or_create_by(scope: nil, config_type: ConfigType.find_by_name('CollectionDescription')) do |val|
      val.value = "";
    end

    %w(ItemDisplay).each do |config|
      ConfigType.find_or_create_by(name: config) do |type|
        type.klass = Hash
      end
    end

    ConfigValue.find_or_create_by(scope: nil, config_type: ConfigType.find_by_name('ItemDisplay')) do |val|
      val.value = {detail_metadata_list:
                       %w(dc.contributor.author dc.title
                                dc.relation.ispartofseries dc.publisher dc.date.issue  dc.description.abstract),
                   short_metadata_list:
                       %w(dc.contributor.author dc.title  dc.relation.ispartofseries dc.date.issued)}
    end


    descr = ConfigType.find_by_name('CollectionDescription')
    DSpace::Rest::Community.topCommuities(:linit => 10000).each do |com|
      if (com.name[0] <= 'M') then
        value = "Describing this very content with words about #{com.name}"
        val = ConfigValue.find_by(config_type: descr, :scope => com.handle)
        val ||= ConfigValue.new(config_type: descr, :scope => com.handle)
        val.value = value
        val.save
      end
      if (com.name[0] == 'M') then
        display =  ConfigType.find_by_name('ItemDisplay')
        value = {short_metadata_list: %w(dc.contributor.author dc.title)}
        val = ConfigValue.find_by(config_type: display, :scope => com.handle)
        val ||= ConfigValue.new(config_type: display, :scope => com.handle)
        val.value = value
        val.save
      end
    end
  end
end
