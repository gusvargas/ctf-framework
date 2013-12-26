db = require '../database'

Controller =
  showLogin: (req, res) ->
    res.render 'login', req.flash()

  showRegister: (req, res) ->
    res.render 'register', req.flash()

  processRegister: (req, res) ->
    team = req.body

    db.createTeam team, (err, results) ->
      if err
        if err.code is 'ER_DUP_ENTRY'
          req.flash 'error', 'Team name already exists.'
          res.redirect '/register'
        else
          req.flash 'error', 'Registration failed.'
          res.redirect '/regster'
        return

      req.flash 'info', 'Team registered successfully.'
      res.redirect '/login'

  gameboard: (req, res) ->
    db.getAllChallenges (err, challenges) ->
      res.render 'gameboard',
        challenges: challenges

  serveAdminUI: (req, res) ->
    res.sendfile './static/adminUI/public/index.html'

module.exports = Controller
