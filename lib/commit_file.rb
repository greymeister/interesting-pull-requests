class CommitFile
  attr_reader :filename, :patch, :status

  def initialize(filename, patch, status)
    @filename = filename
    @patch = patch
    @status = status
  end

end
