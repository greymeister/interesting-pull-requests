# configurer spec

require 'configurer'

TEST_FILE = "authorization_temp.yml"

describe Configurer, "#configure" do
  it "creates a default configuration from yaml" do
    configuration_yaml = File.new(TEST_FILE, "w")
    config_map = {'login' => 'test_login', 'password'  => 'test_password'} 
    configuration_yaml.puts(config_map.to_yaml)
    configuration_yaml.close()
    configuration = Configurer.configure("authorization_temp.yml")
    configuration.login.should eq("test_login")
    configuration.password.should eq("test_password")
  end
  after(:each) do
    File.delete(TEST_FILE) unless File.exists?(TEST_FILE) == false
  end
end

