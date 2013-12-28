mysql = require 'mysql'
utils = require './utils'
_ = require 'underscore'

pool = mysql.createPool
  host: 'localhost'
  user: 'ctf'
  password: 'qwer1234'
  database: 'ctf'
  connectionLimit: 100
  supportBigNumbers: true

executeQuery = (query, params=[], callback) ->
  if typeof params is 'function'
    callback = params
    params = []

  pool.getConnection (err, connection) ->
    if err
      console.error 'Error aquiring connection from pool: ', err
      callback err
      return

    connection.query query, params, (err, results) ->
      connection.release()

      if err
        console.error "Error running query '#{query}': ", err
        callback err
        return

      callback false, results

exports.executeQuery = executeQuery

exports.getTeamByName = (team, callback) ->
  query = 'SELECT * FROM Teams WHERE name = ?'
  executeQuery query, [team], callback

exports.createTeam = (team, callback) ->
  query = 'INSERT INTO Teams SET ?'
  utils.bcryptAttribute team, 'password', (err, safeTeam) ->
    if err
      console.error 'Error hashing team password'
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
  query = 'SELECT * FROM Challenges WHERE id = ?'
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

exports.getScoreboard = (callback) ->
  query = '
    SELECT t.name AS team, SUM(c.points) AS points, MAX(s.time) AS last_submission
    FROM Teams t, Solutions s, Challenges c
    WHERE t.id = s.t_id AND c.id = s.chal_id
    GROUP BY t.name
  '
  executeQuery query, callback

exports.solveChallenge = (chalId, teamId, callback) ->
  query = 'INSERT INTO Solutions SET ?'
  params =
    t_id: teamId
    chal_id: chalId
    time: +(new Date)

  executeQuery query, params, callback

exports.getAllTeams = (callback) ->
  query = 'SELECT id, name FROM Teams'
  executeQuery query, callback

exports.deleteTeam = (id, callback) ->
  query = 'DELETE FROM Teams WHERE id = ?'
  executeQuery query, [id], callback
