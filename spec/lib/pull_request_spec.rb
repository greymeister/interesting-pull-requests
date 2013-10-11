# pull_request spec

require 'pull_request'

describe PullRequest do
  it "is not interesting by default" do
    pull_request = PullRequest.new('1234', 'http://google.com')
    pull_request.interesting?.should eq false
  end

  it "is interesting if interesting! is toggled" do
    pull_request = PullRequest.new('1234', 'http://google.com')
    pull_request.interesting!
    pull_request.interesting?.should eq true
  end
end

describe PullRequest, "#populate_commit_files" do
  it "does not allow modification once commit files are populated" do
    pull_request = PullRequest.new('1234', 'http://google.com')
    pull_request.populate_commit_files(Array.new)
    expect{pull_request.populate_commit_files(Array.new())}.to raise_error(RuntimeError)
  end
end
