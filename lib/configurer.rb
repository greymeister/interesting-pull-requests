require 'yaml'
require 'configuration'

class Configurer
  def self.configure(filename)
    configuration_map = YAML.load_file(filename)
    return Configuration.new(configuration_map['login'], configuration_map['password'])
  end
end
