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
      @navigate ''

  default: (path) ->
    @showChallengesLayout()
    @navigate ''

module.exports = Controller