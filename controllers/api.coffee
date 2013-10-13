db = require '../database'
_ = require 'underscore'

API =
  getAllChallenges: (req, res) ->
    db.getAllChallenges (err, results) ->
      if err
        res.send 500, 'Server Error'
        return

      res.json results

  getChallenge: (req, res) ->
    id = req.params.id
    db.getChallenge id, (err, results) ->
      if err
        res.send 500, 'Server Error'
        return

      if results.length is 0
        res.send 404, 'Not Found'
        return

      res.json results

  createChallenge: (req, res) ->
    attrs = ['name', 'category', 'points', 'target', 'description', 'locked']
    challenge = _.pick req.body, attrs

    unless _.keys(challenge).length is attrs.length
      res.send 400, 'Bad Request'
      return

    db.createChallenge challenge, (err, results) ->
      if err
        res.send 500, 'Server Error'
        return

      res.json challenge


module.exports = API
