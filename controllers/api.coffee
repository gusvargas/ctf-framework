db = require '../database'

API =
  getAllChallenges: (req, res) ->
    db.getAllChallenges (err, results) ->
      if err
        res.send 500, 'fuck'
        return

      res.send results


module.exports = API
