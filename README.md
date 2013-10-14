interesting-pull-requests
================================

### Description

Checks GitHub pull requests for criteria to see whether they are "interesting" based on a configurable set of rules.
See <code>rules.yml</code>.

### Configuration

You will need to create a "credentials.yml" file containing your GitHub API credentials.
Here is an example:

	---
	login: github_user
	password: github_password


This will allow requests against GitHub's API, although you should note their 
[API Rate limiting](http://developer.github.com/v3/#rate-limiting) policy.

### Usage

Run <code>bundle install</code> to install gem dependencies.  Then run the following:

    ./review user/repo

Tests can be run by typing <code>rake</code> or <code>rspec spec</code>.
