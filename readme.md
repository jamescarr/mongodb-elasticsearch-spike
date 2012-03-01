# Elastic Search Spike
This is my spike of using elasticsearch+mongodb during the inaugural
HackCoMo meetup. 

## Setup
You will need
  
  * MongoDB 2.0.0 or greater
  * node.js 0.6.6 or greater
  * coffee-script
  * [elasticsearch](http://www.elasticsearch.org/)

For testing purposes I imported the enron email corpus, you can find it
[here](http://mongodb-enron-email.s3-website-us-east-1.amazonaws.com/).
I had already imported this into my mongodb instance before the meetup
so I saved some time there. You can import it by running

```bash
mongorestore -d enron dump/enron-mail
```

And as always, running npm install from the root of this project will
install all the dependencies needed to run it.

Startup elastic search. You also already have mongodb running, don't you?

## Running It
First run 

```bash
coffee spike.coffee
```

to populate elasticsearch with 10,000 enron emails. Now run

```bash
coffee getit.coffee
```

To run a silly little commandline app to search em. Ctrl+C escapes. 

More to come.


