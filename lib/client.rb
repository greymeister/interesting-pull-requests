require 'configurer'
require 'octokit'
require 'pull_request'
require 'commit_file'

class Client
  attr_accessor :octoclient
  attr_reader :pull_requests

  def initialize
    @configuration = Configurer.configure('credentials.yml')
    @octoclient = Octokit::Client.new :login => @configuration.login, :password => @configuration.password
    @pull_requests = Array.new()
  end

  def populate_pull_requests(github_repo)
    pull_request_hash = @octoclient.pull_requests(github_repo, :open)
    pull_request_hash.each do |pull_request_result|
      @pull_requests << build_pull_request(github_repo, pull_request_result)
    end
  end

  def build_pull_request(github_repo, pull_request_result)
    pull_request_number = pull_request_result['number']
    pull_request_url = pull_request_result['_links']['self']['href']
    pull_request = PullRequest.new(pull_request_number, pull_request_url)
    commit_files = get_commits_for_pull_request(github_repo, pull_request_number)
    pull_request.populate_commit_files(commit_files)
    return pull_request
  end

  def get_commits_for_pull_request(github_repo, pull_request_number)
    commit_files = Array.new
    pull_request_files = @octoclient.pull_request_files(github_repo, pull_request_number)
    pull_request_files.each do |pull_request_file|
      filename = pull_request_file['filename']
      patch = pull_request_file['patch']
      status = pull_request_file['status']
      commit_file = CommitFile.new(filename, patch, status)
      commit_files << commit_file
    end

    return commit_files
  end


end

