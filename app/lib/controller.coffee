App = require 'application'
ChallengesLayout = require 'views/ChallengesLayout'
ChallengeForm = require 'views/ChallengeFormView'

Controller =
  showChallengesLayout: ->
    cl = new ChallengesLayout()
    App.layout.content.show(cl)

  editChallenge: (id) ->
    @showChallengesLayout()

    challenge = App.challenges.get(id)
    if challenge?
      App.vent.trigger 'challenges:edit', challenge
    else
      App.vent.trigger 'challenges'

  default: (path) ->
    @showChallengesLayout()
    App.vent.trigger 'challenges'

module.exports = Controller