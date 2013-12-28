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

  # These are accessed by the templates in /views, e.g., gameboard.hbs
  app.use '/assets/js', express.static "#{__dirname}/static/assets/js"
  app.use '/assets/css', express.static "#{__dirname}/static/assets/css"
  app.use '/assets/img', express.static "#{__dirname}/static/assets/img"

  # These are accessed by the adminUI brunch app
  app.use '/javascripts', express.static "#{__dirname}/static/adminUI/public/javascripts"
  app.use '/stylesheets', express.static "#{__dirname}/static/adminUI/public/stylesheets"
  app.use '/img', express.static "#{__dirname}/static/adminUI/public/img"

# User routes
app.get   '/',                  auth.required, mainController.gameboard
app.get   '/login',             mainController.showLogin
app.post  '/login',             auth.login
app.get   '/logout',            auth.logout
app.get   '/register',          mainController.showRegister
app.post  '/register',          mainController.processRegister

app.get   /^\/admin(\/\w+)*$/,  auth.needsAdmin, mainController.serveAdminUI

# API routes
app.get     '/api/challenges',      auth.required, apiController.getAllChallenges
app.get     '/api/challenges/:id',  auth.required, apiController.getChallenge
app.post    '/api/challenges',      auth.required, apiController.createChallenge
app.put     '/api/challenges/:id',  auth.required, apiController.updateChallenge
app.patch   '/api/challenges/:id',  auth.required, apiController.updateChallenge
app.delete  '/api/challenges/:id',  auth.needsAdmin, apiController.deleteChallenge

app.get     '/api/teams',     auth.needsAdmin, apiController.getAllTeams
app.delete  '/api/teams/:id', auth.needsAdmin, apiController.deleteTeam

app.get     '/api/game/scoreboard',     auth.required, apiController.getScoreboard
app.post    '/api/game/solutions/:id',  auth.required, apiController.submitFlag

app.listen process.env['PORT'] || 1337
