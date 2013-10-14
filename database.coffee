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
        callback true
        return

      callback false, _.extend {}, results,
        params: params

exports.getAllChallenges = (callback) ->
  query = 'SELECT * FROM Challenges'
  executeQuery query, callback

exports.getChallenge = (id, callback) ->
  query = "SELECT * FROM Challenges WHERE id = ?"
  executeQuery query, [id], callback

exports.createChallenge = (challenge, callback) ->
  query = 'INSERT INTO Challenges SET ?'

  utils.bcryptAttribute challenge, 'flag', (err, safeChallenge) ->
    if err
      console.log 'Error hashing flag'
      callback true
      return

    executeQuery query, safeChallenge, callback

exports.updateChallenge = (id, challenge, callback) ->
  query = 'UPDATE Challenges SET ? WHERE id = ?'
  attrs = _.omit challenge, 'id'

  utils.bcryptAttribute attrs, 'flag', (err, safeChallenge) ->
    if err
      console.log 'Error hashing flag'
      callback true
      return

    executeQuery query, [safeChallenge, id], callback

exports.deleteChallenge = (id, callback) ->
  query = 'DELETE FROM Challenges WHERE id = ?'
  executeQuery query, [id], callback
