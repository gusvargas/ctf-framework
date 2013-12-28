template = require 'views/templates/teamsLayout'
TeamSelect = require 'views/TeamSelectView'
TeamEdit = require 'views/TeamEditView'
App = require 'application'

class TeamsLayout extends Backbone.Marionette.Layout
  id: 'teams-layout'
  template: template

  regions:
    teamSelect: '.team-select'
    teamEdit: '.team-edit'

  onRender: ->
    @teamSelect.show new TeamSelect
      collection: App.teams
    @teamEdit.show new TeamEdit

    @teamSelect.currentView.initChosen()

module.exports = TeamsLayout
