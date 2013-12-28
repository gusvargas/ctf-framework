template = require '/views/templates/teamsLayout'
TeamSelect = require '/views/TeamSelectView'
App = require 'application'

class TeamsLayout extends Backbone.Marionette.Layout
  id: 'teams-layout'
  template: template

  regions:
    teamSelect: '.team-select'

  onRender: ->
    @teamSelect.show new TeamSelect
      collection: App.teams

    @teamSelect.currentView.initChosen()

module.exports = TeamsLayout
