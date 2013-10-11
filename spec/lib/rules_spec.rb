# rules spec

require 'rules'

TEST_PATCH_MATCHES = '@@ -132,7 +132,7 @@ module Test /dev/null @@ -1000,7 +1000,7 @@ module Test'
TEST_PATCH_SUB_MATCH = '@@ -132,7 +132,7 @@ module /dev/nullTest @@ -1000,7 +1000,7 @@ module Test'
TEST_PATCH_NO_MATCH = '@@ -132,7 +132,7 @@ module Test @@ -1000,7 +1000,7 @@ module Test'
TEST_PATCH_SC_MATCH = '@@ -132,7 +132,7 @@ module Test %x @@ -1000,7 +1000,7 @@ module Test'
TEST_PATCH_RAISE_NO_MATCH = 'end.to raise_error(Puppet::Error, /Attempt to assign to a reserved variable name'
TEST_PATCH_DOT_WRITE = '@@ -132,7 +132,7 @@ module Test .write @@ -1000,7 +1000,7 @@ module Test'

describe PatchContainsKeywordsRule, "#patch_matches" do
  it "should match when a keyword is present" do
    rule = PatchContainsKeywordsRule.new()
    result = rule.patch_matches('/dev/null', TEST_PATCH_MATCHES)
    result.should eq(true)
  end

  it "should not match when a keyword is not present" do
    rule = PatchContainsKeywordsRule.new()
    result = rule.patch_matches('/dev/null', TEST_PATCH_NO_MATCH)
    result.should eq(false)
  end

  it "should not match when a keyword is a substring" do
    rule = PatchContainsKeywordsRule.new()
    result = rule.patch_matches('/dev/null', TEST_PATCH_SUB_MATCH)
    result.should eq(false)
  end

  it "should match when a special character keyword is present" do
    rule = PatchContainsKeywordsRule.new()
    result = rule.patch_matches('%x', TEST_PATCH_SC_MATCH)
    result.should eq(true)
  end

  it "should not match when raise is present as substring" do
    rule = PatchContainsKeywordsRule.new()
    result = rule.patch_matches('raise', TEST_PATCH_RAISE_NO_MATCH)
    result.should eq(false)
  end

  it "should match .write as a string" do
    rule = PatchContainsKeywordsRule.new()
    result = rule.patch_matches('\.write', TEST_PATCH_DOT_WRITE)
    result.should eq(true)
  end

end

describe PatchContainsGemModificationsRule, "#pull_request_is_interesting" do
  it "should match when gemfile is modified" do
    mockCommitFile = double("CommitFile")
    mockCommitFile.stub(:filename) {"Gemfile"}
    commitList = [mockCommitFile]
    mockPullRequest = double("PullRequest")
    mockPullRequest.stub(:commit_files) { commitList}
    mockPullRequest.should_receive(:interesting!)
    rule = PatchContainsGemModificationsRule.new()
    rule.pull_request_is_interesting(mockPullRequest)
  end

  it "should match when .gemspec is modified" do
    mockCommitFile = double("CommitFile")
    mockCommitFile.stub(:filename) {".gemspec"}
    commitList = [mockCommitFile]
    mockPullRequest = double("PullRequest")
    mockPullRequest.stub(:commit_files) { commitList}
    mockPullRequest.should_receive(:interesting!)
    rule = PatchContainsGemModificationsRule.new()
    rule.pull_request_is_interesting(mockPullRequest)
  end

  it "should not match when anything else is modified" do
    mockCommitFile = double("CommitFile")
    mockCommitFile.stub(:filename) {"README"}
    commitList = [mockCommitFile]
    mockPullRequest = double("PullRequest")
    mockPullRequest.stub(:commit_files) { commitList}
    rule = PatchContainsGemModificationsRule.new()
    rule.pull_request_is_interesting(mockPullRequest)
  end
end

describe PatchDoesNotChangeSpecsRule, "#pull_request_is_interesting" do
  it "should match when there are no spec modifications" do
    mockCommitFile1 = double("CommitFile")
    mockCommitFile1.stub(:filename) {"README"}
    mockCommitFile2 = double("CommitFile")
    mockCommitFile2.stub(:filename) {"lib/test.rb"}
    commitList = [mockCommitFile1, mockCommitFile2]
    mockPullRequest = double("PullRequest")
    mockPullRequest.stub(:commit_files) { commitList}
    mockPullRequest.should_receive(:interesting!)
    rule = PatchDoesNotChangeSpecsRule.new()
    rule.pull_request_is_interesting(mockPullRequest)
  end
  
  it "should not match when there are spec modifications" do
    mockCommitFile1 = double("CommitFile")
    mockCommitFile1.stub(:filename) {"README"}
    mockCommitFile2 = double("CommitFile")
    mockCommitFile2.stub(:filename) {"spec/lib/test.rb"}
    commitList = [mockCommitFile1, mockCommitFile2]
    mockPullRequest = double("PullRequest")
    mockPullRequest.stub(:commit_files) { commitList}
    rule = PatchDoesNotChangeSpecsRule.new()
    rule.pull_request_is_interesting(mockPullRequest)
  end
end

    
    
