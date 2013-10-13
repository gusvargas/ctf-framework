db = require '../database'
_ = require 'underscore'

validateChallenge = (challenge) ->
  attrs = ['name', 'category', 'points', 'target', 'description', 'flag', 'locked']
  challenge = _.pick challenge, attrs

  unless _.keys(challenge).length is attrs.length
    return false

  challenge

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
    challenge = validateChallenge req.body

    unless challenge
      res.send 400, 'Bad Request'
      return

    db.createChallenge challenge, (err, results) ->
      if err
        res.send 500, 'Server Error'
        return

      challenge.id = results.insertId
      res.json challenge

  updateChallenge: (req, res) ->
    id = req.params.id
    updatedChallenge = validateChallenge req.body

    unless updatedChallenge
      res.send 400, 'Bad Request'
      return

    db.updateChallenge id, updatedChallenge, (err, results) ->
      if err
        res.send 500, 'Server Error'
        return

      if results.changedRows is 0
        res.send 404, 'Not Found'
        return

      res.json updatedChallenge

  deleteChallenge: (req, res) ->
    id = req.params.id

    db.deleteChallenge id, (err, results) ->
      if err
        res.send 500, 'Server Error'
        return

      if results.affectedRows is 0
        res.send 404, 'Not Found'
        return

      res.send 200


module.exports = API
