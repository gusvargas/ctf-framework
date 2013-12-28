db = require '../database'
utils = require '../utils'
_ = require 'underscore'
bcrypt = require 'bcrypt'

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
    challenge = utils.validateChallenge req.body, true

    unless challenge
      res.send 400, 'Bad Request'
      return

    utils.bcryptAttribute challenge, 'flag', (err, safeChallenge) ->
      if err
        console.error 'Error hashing flag'
        return

      db.createChallenge safeChallenge, (err, results) ->
        if err
          res.send 500, 'Server Error'
          return

        challenge.id = results.insertId
        res.json challenge

  updateChallenge: (req, res) ->
    id = req.params.id
    updatedChallenge = utils.validateChallenge req.body

    unless updatedChallenge
      res.send 400, 'Bad Request'
      return

    updatedChallenge = _.omit updatedChallenge, 'id'
    utils.bcryptAttribute updatedChallenge, 'flag', (err, safeChallenge) ->
      if err
        console.log 'Error hashing flag'
        return

      db.updateChallenge id, safeChallenge, (err, results) ->
        if err
          res.send 500, 'Server Error'
          return

        if results.affected is 0
          res.send 404, 'Not Found'
          return

        res.json safeChallenge

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

  getScoreboard: (req, res) ->
    db.getScoreboard (err, results) ->
      if err
        res.send 500, 'Server Error'
        return

      res.json results

  submitFlag: (req, res) ->
    teamId = req.user.id
    chalId = req.params.id
    flag = req.body.flag

    db.getChallenge chalId, (err, result) ->
      if err
        res.send 500, 'Server Error'
        return

      if results.length is 0
        res.send 404, 'Not Found'
        return

      challenge = _.first result
      bcrypt.compare flag, challenge.flag, (err, match) ->
        unless match
          res.send 400, 'Incorrect Submission'
          return

        db.solveChallenge chalId, teamId, ->
          res.send 200

  getAllTeams: (req, res) ->
    db.getAllTeams (err, results) ->
      if err
        res.send 500, 'Server Error'
        return

      res.json results

  deleteTeam: (req, res) ->
    teamId = req.params.id

    db.deleteTeam teamId, (err, results) ->
      if err
        res.send 500, 'Server Error'
        return

      if results.affectedRows is 0
        res.send 404, 'Not Found'
        return

      res.send 200

module.exports = API
