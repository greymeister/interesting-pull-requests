interesting-pull-requests
================================

### Description

Checks GitHub pull request for criteria to see whether they are "interesting" based on a configurable set of rules.

### Configuration

You will need to create a "credentials.yml" file containing the following:

	---
	login: github_user
	password: github_password


This will allow reqeusts against GitHub's API, although you will still be effected by their 
[API Rate limiting](http://developer.github.com/v3/#rate-limiting).

### Usage

Run <code>bundle install</code> to install gem dependencies.  Then run the following:

    ./review user/repo

Optionally, specs can be run by just typing <code>rake</code> or <code>rake test</code>.
