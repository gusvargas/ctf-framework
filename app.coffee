express = require 'express'
hbs = require 'express3-handlebars'
flash = require 'connect-flash'

auth = require './auth'
mainController = require './controllers/main'
apiController = require './controllers/api'

app = express()

templateOpts =
  defaultLayout: false
  extname: '.hbs'

app.configure ->
  app.engine '.hbs', hbs templateOpts
  app.set 'view engine', '.hbs'

  app.use express.compress()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.session secret: 'secret'
  app.use flash()
  app.use auth.passport.initialize()
  app.use auth.passport.session()

  app.use '/javascripts', express.static "#{__dirname}/static/adminUI/public/javascripts"
  app.use '/stylesheets', express.static "#{__dirname}/static/adminUI/public/stylesheets"
  app.use '/img', express.static "#{__dirname}/static/adminUI/public/img"

# User routes
app.get '/', auth.required, mainController.scoreboard
app.get '/login', mainController.showLogin
app.get '/logout', mainController.logout
app.post '/login', auth.process
app.get '/register', mainController.showRegister
app.post '/register', mainController.processRegister
app.get /^\/admin(\/\w+)*$/, auth.required, mainController.serveAdminUI

# API routes
app.get     '/api/challenges',      apiController.getAllChallenges
app.get     '/api/challenges/:id',  apiController.getChallenge
app.post    '/api/challenges',      apiController.createChallenge
app.put     '/api/challenges/:id',  apiController.updateChallenge
app.patch   '/api/challenges/:id',  apiController.updateChallenge
app.delete  '/api/challenges/:id',  apiController.deleteChallenge

app.listen 1337
