mainController = require '../controllers/main'

module.exports = (app, auth) ->
  # User routes
  app.get   '/',                  auth.required, mainController.gameboard
  app.get   '/login',             mainController.showLogin
  app.post  '/login',             auth.login
  app.get   '/logout',            auth.logout
  app.get   '/register',          mainController.showRegister
  app.post  '/register',          mainController.processRegister

  app.get   /^\/admin(\/\w+)*$/,  auth.needsAdmin, mainController.serveAdminUI
