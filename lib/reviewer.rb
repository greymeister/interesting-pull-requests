$:.unshift File.dirname(__FILE__)

require 'yaml'
require 'client'
require 'rules'

class Reviewer
  def initialize(github_repo)
    @rules = Reviewer.build_rules_config
    @client = Client.new()
    @client.populate_pull_requests(github_repo)
  end
  
  def self.build_rules_config
    rules = []
    rule_config = YAML.load_file('rules.yml')
    rule_list = rule_config[:rules]
    rule_list.each do |rule|
      rule_class = Object.const_get(rule)
      rules << rule_class.new()
    end    
    return rules
  end    

  def review_pull_requests
    @rules.each do |rule| 
      pull_requests = @client.pull_requests.select {|pull_request| pull_request.interesting? == false}
      pull_requests.each do |pull_request|
        rule.pull_request_is_interesting(pull_request)
      end
    end
  end

  def review_results
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



