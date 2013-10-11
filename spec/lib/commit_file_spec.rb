# commit_file spec

require 'commit_file'

describe CommitFile do
  it "has readable attributes" do
    commit_file = CommitFile.new('1', '2', '3')
    commit_file.filename.should eq ('1')
    commit_file.patch.should eq ('2')
    commit_file.status.should eq ('3')
  end
end
