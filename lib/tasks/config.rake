namespace :config do
  desc "CLI to work with ConfigValues"
  task list: :environment do
    ConfigValue.all().each {|v| puts v.inspect}
  end

end
