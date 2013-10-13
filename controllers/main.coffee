Controller =
  serveAdminUI: (req, res) ->
    res.sendfile './static/adminUI/public/index.html'

module.exports = Controller
