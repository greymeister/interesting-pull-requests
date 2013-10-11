class CommitFile
  attr_reader :filename, :patch, :status

  def initialize(filename, patch, status)
    @filename = filename
    @patch = patch
    @status = status
  end

  def to_s
    return "#{filename}"
  end

end
