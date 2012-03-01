elastical = require 'elastical'
eyes      = require 'eyes'
events    = require 'events'
em        = new events.EventEmitter()
client    = new elastical.Client()


em.on 'prompt', ->
  process.stdout.write("Search: ")

process.openStdin().on 'data', (term) ->
  client.search query:term.toString(), (err, results, res) ->
    eyes.inspect results
    em.emit 'prompt'

em.emit 'prompt'
