somata_socketio = require 'somata-socketio'
mime = require 'mime'
fs = require 'fs'

app = somata_socketio
    port: 10145

app.get '/', (req, res) -> res.render 'base'

serveStatic = (req, res) ->
    fs.readFile '..' + req.path, (err, file) ->
        res.setHeader 'Content-Type', mime.lookup req.path
        res.end file

app.get '/img/*', serveStatic
app.get '/font/*', serveStatic

app.start()
