IsYourRequestHotOrNot
================================

### Description

Library to determine whether a pull request to a GitHub repo is "interesting" as defined by the following criteria:

*
*
*

### Pull Requests and other Strangers

###Strangers and other Pull Requests

### Configuration

You will need to create a "credentials.yml" file containing the following:

	login: 'github\_username'
	password: 'github\_password'


This will allow reqeusts against GitHub's API, although you will still be effected by their [API Rate limiting](http://developer.github.com/v3/#rate-limiting).

### Usage

./script/