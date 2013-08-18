App = require 'application'
ChallengesLayout = require 'views/ChallengesLayout'
ChallengeForm = require 'views/ChallengeFormView'

class Router extends Backbone.Router
  routes:
    'challenges': 'showChallengesLayout'
    'challenges/edit/:id': 'editChallenge'

  showChallengesLayout: ->
    cl = new ChallengesLayout()
    App.layout.content.show(cl)

  editChallenge: (id) ->
    @showChallengesLayout()

    challenge = App.challenges.get(id)
    App.vent.trigger 'editChallenge', challenge

module.exports = Router