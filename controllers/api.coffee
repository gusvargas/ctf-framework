db = require '../database'

API =
  getAllChallenges: (req, res) ->
    db.getAllChallenges (err, results) ->
      if err
        res.send 500, 'Server Error'
        return

      res.send results


module.exports = API
