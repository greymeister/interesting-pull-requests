# client spec

require 'client'

describe Client, "#populate_pull_requests" do
  it "should request open pull requests from github" do
    client = Client.new()
    octoclient = double()
    octoclient.should_receive(:pull_requests).with(TEST_REPO, :open).and_return([])
    client.instance_variable_set(:@octoclient, octoclient)
    client.populate_pull_requests(TEST_REPO)
  end
end

