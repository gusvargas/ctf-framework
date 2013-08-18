App = require 'application'
ChallengesLayout = require 'views/ChallengesLayout'
ChallengeForm = require 'views/ChallengeFormView'

class Router extends Backbone.Router
  routes:
    'challenges': 'showChallengesLayout'
    'challenges/edit/:id': 'editChallenge'
    '*path': 'default'

  showChallengesLayout: ->
    cl = new ChallengesLayout()
    App.layout.content.show(cl)

  editChallenge: (id) ->
    @showChallengesLayout()

    challenge = App.challenges.get(id)
    if challenge?
      App.vent.trigger 'editChallenge', challenge
    else
      @navigate ''

  default: (path) ->
    @showChallengesLayout()
    @navigate ''

module.exports = Router