App = require 'application'
ChallengesLayout = require 'views/ChallengesLayout'
ChallengeForm = require 'views/ChallengeFormView'

class Router extends Backbone.Router
  routes:
    'challenges': 'challenges'

  challenges: ->
    cl = new ChallengesLayout()
    App.layout.content.show(cl)

module.exports = Router