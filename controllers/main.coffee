db = require '../database'

Controller =
  showLogin: (req, res) ->
    res.render 'login'

  processLogin: (req, res) ->

  scoreboard: (req, res) ->
    db.getAllChallenges (err, challenges) ->
      res.render 'default',
        challenges: challenges

  serveAdminUI: (req, res) ->
    res.sendfile './static/adminUI/public/index.html'

module.exports = Controller
