mysql = require 'mysql'
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

      callback false, results

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
  attrs = _.omit challenge, 'id'

  query = 'UPDATE Challenges SET ? WHERE id = ?'
  executeQuery query, [attrs, id], callback
