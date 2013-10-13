class PullRequest
  attr_reader :commit_files, :id, :url

  def self.build_from_pull_request_result(pull_request_result)
    pull_request_number = pull_request_result['number']
    pull_request_url = pull_request_result['_links']['self']['href']
    PullRequest.new(pull_request_number, pull_request_url)
  end

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
