express = require 'express'
hbs = require 'express3-handlebars'
flash = require 'connect-flash'

auth = require './auth'
routes = require './routes'

app = express()

templateOpts =
  defaultLayout: false
  extname: '.hbs'
  helpers: require './views/handlebars-helpers'

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

routes(app, auth)

app.listen process.env['PORT'] || 1337
