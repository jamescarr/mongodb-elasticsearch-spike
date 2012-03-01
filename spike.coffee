elastical   = require 'elastical'
mongodb     = require 'mongodb'
events      = require 'events'
request     = require 'request'
em          = new events.EventEmitter()
mongoserver = new mongodb.Server('localhost', 27017)
db          = new mongodb.Db('enron', mongoserver)

db.open ->
  db.collection 'messages', (err, collection) ->
    em.emit '/mongo/connected', collection

em.on '/mongo/connected', (collection)->
  drop 'messages', ->
    # create the index
    props = 
      url: 'http://localhost:9200/messages'
      index:
        analysis:
          analyzer:
            synonym:
              tokenizer: "whitespace"
              filter: [ "synonym" ]

          filter:
            synonym:
              type: "synonym"
              synonyms_path: "analysis/synonym.txt"

    request.put props, (err, res) ->
      i = 0
      # populate it
      client = new elastical.Client()
      collection.find (err, cursor) ->
        cursor.each (err, doc) ->
          email = 
            body: doc.body
            subject: doc.headers.Subject
            from: doc.headers.From
            to: doc.headers.To

          client.index 'messages', 'messages', email, (err, res) ->
            process.stderr.write("#{(i++)} messages indexed!\r")
            process.exit() if i is 10000

drop = (index, cb) ->
  request.del "http://localhost:9200/#{index}/", cb
