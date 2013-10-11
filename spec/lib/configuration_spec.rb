# configuration spec

require 'configuration'

describe Configuration do
  it "has readable attributes" do
    configuration = Configuration.new('test_user', 'test_password')
    configuration.login.should eq ('test_user')
    configuration.password.should eq ('test_password')
  end
end
