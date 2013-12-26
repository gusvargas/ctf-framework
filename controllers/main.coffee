db = require '../database'

Controller =
  showLogin: (req, res) ->
    res.render 'login', req.flash()

  logout: (req, res) ->
    req.logout()
    res.redirect('/login')

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

  scoreboard: (req, res) ->
    db.getAllChallenges (err, challenges) ->
      res.render 'default',
        challenges: challenges

  serveAdminUI: (req, res) ->
    res.sendfile './static/adminUI/public/index.html'

module.exports = Controller
