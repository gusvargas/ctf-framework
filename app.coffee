express = require 'express'

mainController = require './controllers/main'
apiController = require './controllers/api'

app = express()

app.configure ->
  app.use express.compress()
  app.use express.bodyParser()
  app.use '/javascripts', express.static "#{__dirname}/static/adminUI/public/javascripts"
  app.use '/stylesheets', express.static "#{__dirname}/static/adminUI/public/stylesheets"
  app.use '/img', express.static "#{__dirname}/static/adminUI/public/img"

app.get /^\/admin(\/\w+)*$/, mainController.serveAdminUI

app.get '/api/challenges', apiController.getAllChallenges
app.get '/api/challenges/:id', apiController.getChallenge
app.post '/api/challenges', apiController.createChallenge

app.listen 1337
