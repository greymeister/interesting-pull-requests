class Rule
  def pull_request_is_interesting(pull_request)
    raise NotImplementedError, "Implement this method in a child class"
  end
end

class PatchContainsKeywordsRule < Rule
  def pull_request_is_interesting(pull_request)
    keyword_list = ['/dev/null', 'raise', '\.write', '%x', 'exec']
    commit_files = pull_request.commit_files 
    keyword_list.each do |keyword|
      matching_files = commit_files.select {|commit_file| patch_matches(keyword, commit_file.patch)}
      if matching_files.length > 0
        pull_request.interesting!
      end
    end
  end

  def patch_matches(keyword, patch)
    return /\W#{keyword}\W/.match(patch) != nil
  end
    
end

class PatchContainsGemModificationsRule < Rule
  def pull_request_is_interesting(pull_request)
    gem_file_list = ['Gemfile', '.gemspec']
    commit_files = pull_request.commit_files 
    gem_file_list.each do |filename|
      matching_files = commit_files.select {|commit_file| commit_file.filename == filename }
      if matching_files.length > 0
        pull_request.interesting!
      end
    end
  end

end

class PatchDoesNotChangeSpecsRule < Rule
  def pull_request_is_interesting(pull_request)
    commit_files = pull_request.commit_files 
    matching_files = commit_files.select {|commit_file| commit_file.filename.start_with?('spec/')}
    if matching_files.length == 0
      pull_request.interesting!
    end
  end

end
