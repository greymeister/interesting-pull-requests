require 'octokit'
require 'configurer'
require 'pull_request'
require 'commit_file'

class Client
  attr_reader :pull_requests

  def initialize
    @configuration = Configurer.configure('credentials.yml')
    @octoclient = Octokit::Client.new :login => @configuration.login, :password => @configuration.password
    @pull_requests = Array.new()
  end

  def populate_pull_requests(github_repo)
    begin
      pull_request_hash = @octoclient.pull_requests(github_repo, :open)
      pull_request_hash.each do |pull_request_result|
        @pull_requests << build_pull_request(github_repo, pull_request_result)
      end
    rescue Octokit::ClientError => client_error 
      $stderr.puts "Error accessing repository #{github_repo}"
      $stderr.puts client_error.message
    end
  end

  def build_pull_request(github_repo, pull_request_result)
    pull_request = PullRequest.build_from_pull_request_result(pull_request_result) 
    commit_files = get_commits_for_pull_request(github_repo, pull_request.id)
    pull_request.populate_commit_files(commit_files)
    return pull_request
  end

  def get_commits_for_pull_request(github_repo, pull_request_number)    
    commit_files = Array.new
    begin
      pull_request_files = @octoclient.pull_request_files(github_repo, pull_request_number)
      pull_request_files.each do |pull_request_file|
        commit_file = CommitFile.build_from_pull_request_file(pull_request_file)
        commit_files << commit_file
      end
      
    rescue Octokit::ClientError => client_error
      $stderr.puts "Error accessing files for #{github_repo}"
      $stderr.puts client_error.message
    end  
     
    return commit_files    

  end

end

