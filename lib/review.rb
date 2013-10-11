#!/usr/bin/env ruby

require 'reviewer'

githubRepo = ARGV[0]

reviewer = Reviewer.new(githubRepo)
reviewer.review_pull_requests
reviewer.review_results





