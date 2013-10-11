class PullRequest
  attr_reader :commit_files, :id, :url

  def initialize(id, url)
    @id = id
    @url = url
    @interesting = false
    @commit_files = Array.new
  end
  
  def interesting?
    @interesting == true
  end

  def interesting!
    @interesting = true
  end

  def populate_commit_files(files)
    @commit_files.concat(files)
    @commit_files.freeze
  end

end
