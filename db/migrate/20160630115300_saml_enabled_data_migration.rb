class SamlEnabledDataMigration < ActiveRecord::Migration
  keys = YAML::load(File.open("db/fixtures/configurations.yml"))

  @configurations = [
    keys[160],
    keys[161],
    keys[162],
    keys[163],
    keys[164],
    keys[165]
  ]

  def self.up
    @configurations.each do |config|
      if Configuration.find_by_key(config['key']).nil?
        Configuration.create(:key => config['key'],
                             :value => config['value'],
                             :system_key => config['system_key'] == 't')
      end
    end
  end

  def self.down
    @configurations.each do |config|
      c = Configuration.find_by_key(config['key'])
      unless c.nil?
        c.destroy
      end
    end
  end
end
