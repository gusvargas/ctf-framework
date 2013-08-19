class Router extends Backbone.Marionette.AppRouter
  appRoutes:
    'challenges': 'showChallengesLayout'
    'challenges/edit/:id': 'editChallenge'
    '*path': 'default'

module.exports = Router