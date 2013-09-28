class Router extends Backbone.Marionette.AppRouter
  appRoutes:
    'challenges': 'showChallengesLayout'
    'challenges/edit/:id': 'editChallenge'
    'teams': 'showTeamsLayout'
    '*path': 'default'

module.exports = Router
