mysql = require 'mysql'

pool = mysql.createPool
  host: 'localhost'
  user: 'root'
  password: 'g0t_r00t'
  database: 'ctf'
  connectionLimit: 10

executeQuery = (query, callback) ->
  pool.getConnection (err, connection) ->
    if err
      console.log err
      callback true
      return

    connection.query sql, (err, results) ->
      if err
        console.log err
        callback true

      callback false, results

exports.getAllChallenges = (callback) ->
  sql = 'SELECT * FROM Challenges'
  executeQuery sql, callback
