apiController = require '../controllers/api'

module.exports = (app, auth) ->
  # API routes
  app.get     '/api/challenges',      auth.required, apiController.getAllChallenges
  app.get     '/api/challenges/:id',  auth.required, apiController.getChallenge
  app.post    '/api/challenges',      auth.required, apiController.createChallenge
  app.put     '/api/challenges/:id',  auth.required, apiController.updateChallenge
  app.patch   '/api/challenges/:id',  auth.required, apiController.updateChallenge
  app.delete  '/api/challenges/:id',  auth.needsAdmin, apiController.deleteChallenge

  app.get     '/api/teams',     auth.needsAdmin, apiController.getAllTeams
  app.put     '/api/teams/:id', auth.needsAdmin, apiController.updateTeam
  app.patch   '/api/teams/:id', auth.needsAdmin, apiController.updateTeam
  app.delete  '/api/teams/:id', auth.needsAdmin, apiController.deleteTeam

  app.get     '/api/game/scoreboard',     auth.required, apiController.getScoreboard
  app.post    '/api/game/solutions/:id',  auth.required, apiController.submitFlag
