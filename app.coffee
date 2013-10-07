express = require 'express'

api = require './controllers/api'

app = express()

app.configure ->
  app.use express.compress()
  app.use express.bodyParser()
  app.use '/admin', express.static "#{__dirname}/static/adminUI/public"

app.get '/api/challenges', api.getAllChallenges

app.listen 1337
