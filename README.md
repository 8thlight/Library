Library
=======

App keeps track of books in the 8th Light library by managing the checkout and return process.

Getting Started
---------------

Clone the repo and get your database set up.

`git clone git@github.com:8thlight/Library.git`  
`cd Library`  
`rake db:create`  
`rake db:migrate`  
`rake db:test:prepare`  

Specs
-----

Install [redis](http://redis.io)

Start the server with `redis-server`  
Run the specs with `rspec`

