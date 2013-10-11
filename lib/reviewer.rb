require 'client'
require 'rules'

class Reviewer
  def initialize(github_repo)
    # These could be externally configured in a YAML file for more flexibility
    @rules = [PatchContainsGemModificationsRule.new(), PatchDoesNotChangeSpecsRule.new(), PatchContainsKeywordsRule.new()]
    @client = Client.new()
    @client.populate_pull_requests(github_repo)
  end

  def review_pull_requests
    @rules.each do |rule| 
      pull_requests = @client.pull_requests.select {|pull_request| pull_request.interesting? == false}
      pull_requests.each do |pull_request|
        rule.pull_request_is_interesting(pull_request)
      end
    end
  end

  def review_results()
    @client.pull_requests.each do |pull_request|
       if pull_request.interesting?
         status = "Interesting"
       else
         status = "Not Interesting"
       end
       puts "#{pull_request.url} - #{status}"
     end
  end

end



