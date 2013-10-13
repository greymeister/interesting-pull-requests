# reviewer spec

require 'reviewer'

TEST_REPO = 'test/test'

describe Reviewer, "#build_rules_config" do
  it "should load 3 rules" do
    rules = Reviewer.build_rules_config
    rules.should have(3).items
  end

  it "should load instances of Rule" do
    rules = Reviewer.build_rules_config
    rules.each do |rule|
      rule.should be_kind_of(Rule)
    end
  end
end

describe Reviewer, "#review_pull_requests" do
  it "should populate pull requests" do
    reviewer = Reviewer.new(TEST_REPO)
    client = double()
    client.should_receive(:populate_pull_requests).with(TEST_REPO)
    client.stub(:pull_requests).and_return(Array.new)
    reviewer.instance_variable_set(:@client, client) 
    reviewer.review_pull_requests
  end

  it "should apply each rule to each pull request" do
    reviewer = Reviewer.new(TEST_REPO)
    client = double()
    client.should_receive(:populate_pull_requests).with(TEST_REPO)
    mockPullRequest = double()
    mockPullRequest.stub(:interesting?).and_return(false)
    client.stub(:pull_requests).and_return([mockPullRequest])
    reviewer.instance_variable_set(:@client, client) 
    mockRule = double()
    mockRule.should_receive(:pull_request_is_interesting).exactly(3).times 
    mockRules = [mockRule, mockRule, mockRule] 
    reviewer.instance_variable_set(:@rules, mockRules)
    reviewer.review_pull_requests
  end
end

describe Reviewer, "#review_results" do
  it "should print interesting for interesting results" do
    reviewer = Reviewer.new(TEST_REPO)
    pull_request = double()
    pull_request.stub(:interesting?).and_return(true)
    pull_request.stub(:url).and_return("http://github.com/test/test")
    client = double()
    client.stub(:pull_requests).and_return([pull_request])
    reviewer.instance_variable_set(:@client, client) 
    reviewer.should_receive(:puts).with("http://github.com/test/test - Interesting")
    reviewer.review_results
  end
  
  it "should print not interesting for uninteresting results" do
    reviewer = Reviewer.new(TEST_REPO)
    pull_request = double()
    pull_request.stub(:interesting?).and_return(false)
    pull_request.stub(:url).and_return("http://github.com/test/test")
    client = double()
    client.stub(:pull_requests).and_return([pull_request])
    reviewer.instance_variable_set(:@client, client) 
    reviewer.should_receive(:puts).with("http://github.com/test/test - Not Interesting")
    reviewer.review_results
  end
end
