App = require 'application'
ChallengesLayout = require 'views/ChallengesLayout'
TeamsLayout = require 'views/TeamsLayout'
ChallengeForm = require 'views/ChallengeFormView'

Controller =
  showChallengesLayout: ->
    cl = new ChallengesLayout
    App.layout.content.show cl

  editChallenge: (id) ->
    @showChallengesLayout()

    challengesLayout = App.layout.content.currentView

    challenge = App.challenges.get(id)
    if challenge?
      challengeForm = new ChallengeForm
        collection: App.challenges
        model: challenge
      challengesLayout.sideBar.show challengeForm
    else
      App.router.navigate 'challenges'

  showTeamsLayout: ->
    tl = new TeamsLayout
    App.layout.content.show tl

  default: (path) ->
    @showChallengesLayout()
    App.vent.trigger 'challenges'

App.vent.on 'challenges', =>
  Controller.showChallengesLayout()
  App.router.navigate 'challenges'

App.vent.on 'challenges:edit', (challenge) =>
  Controller.editChallenge challenge
  App.router.navigate "challenges/edit/#{challenge.get('id')}"

App.vent.on 'challenges:edit:close', =>
  Controller.showChallengesLayout()
  App.router.navigate 'challenges'

App.vent.on 'teams', =>
  Controller.showTeamsLayout()
  App.router.navigate 'teams'

module.exports = Controller
