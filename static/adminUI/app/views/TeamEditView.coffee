template = require 'views/templates/teamEdit'
App = require 'application'

class TeamEdit extends Backbone.Marionette.ItemView
  template: template

  events:
    'click .delete': 'deleteTeam'

  initialize: ->
    @listenTo App.vent, 'teams:edit', @setModel

  setModel: (model) ->
    if @model?
      @stopListening @model

    @model = model

  deleteTeam: ->
    @model?.destroy()

module.exports = TeamEdit
