somata_socketio = require 'somata-socketio'

app = somata_socketio
    port: 10145

app.get '/', (req, res) -> res.render 'base'

all_names = "joe james jack jillian jeffrey george fred frank frida".split(' ')
app.get '/search', (req, res) ->
    {q} = req.query
    respond = ->
        res.json all_names.filter (n) -> n.match q
    setTimeout respond, 500

app.post '/contact', (req, res) ->
    console.log 'Just got contacted by', req.body.email
    res.json success: true

app.start()
