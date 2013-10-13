class CommitFile
  attr_reader :filename, :patch, :status

  def self.build_from_pull_request_file(pull_request_file)
    filename = pull_request_file['filename']
    patch = pull_request_file['patch']
    status = pull_request_file['status']
    CommitFile.new(filename, patch, status)
  end

  def initialize(filename, patch, status)
    @filename = filename
    @patch = patch
    @status = status
  end

  def to_s
    return "#{filename}"
  end

end
