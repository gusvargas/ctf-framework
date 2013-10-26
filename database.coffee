mysql = require 'mysql'
utils = require './utils'
_ = require 'underscore'

pool = mysql.createPool
  host: 'localhost'
  user: 'root'
  password: 'g0t_r00t'
  database: 'ctf'
  connectionLimit: 10

executeQuery = (query, params=[], callback) ->
  pool.getConnection (err, connection) ->
    if err
      console.log 'Error aquiring connection from pool: ', err
      callback true
      return

    connection.query query, params, (err, results) ->
      connection.release()

      if err
        console.log "Error running query '#{query}': ", err
        callback err
        return

      callback false, results

exports.getTeamByName = (team, callback) ->
  query = 'SELECT * FROM Teams WHERE name = ?'
  executeQuery query, [team], callback

exports.createTeam = (team, callback) ->
  query = 'INSERT INTO Teams SET ?'
  utils.bcryptAttribute team, 'password', (err, safeTeam) ->
    if err
      console.log 'Error hashing team password'
      callback err
      return

    executeQuery query, team, callback

exports.getTeamById = (id, callback) ->
  query = 'SELECT * FROM Teams WHERE id = ?'
  executeQuery query, [id], callback

exports.getAllChallenges = (callback) ->
  query = 'SELECT * FROM Challenges'
  executeQuery query, callback

exports.getChallenge = (id, callback) ->
  query = "SELECT * FROM Challenges WHERE id = ?"
  executeQuery query, [id], callback

exports.createChallenge = (challenge, callback) ->
  query = 'INSERT INTO Challenges SET ?'
  executeQuery query, challenge, callback

exports.updateChallenge = (id, challenge, callback) ->
  query = 'UPDATE Challenges SET ? WHERE id = ?'
  executeQuery query, [challenge, id], callback

exports.deleteChallenge = (id, callback) ->
  query = 'DELETE FROM Challenges WHERE id = ?'
  executeQuery query, [id], callback
