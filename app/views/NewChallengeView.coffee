template = require 'views/templates/newChallenge'
App = require 'application'

class NewChallenge extends Backbone.Marionette.ItemView
  template: template
  className: 'new-challenge-form'

  events:
    'click button': 'createChallenge'

  serializeData: ->
    context = {}
    editing = @model?

    if editing
      _.extend context, @model.toJSON(), {editing:editing}

    context

  initialize: ->
    @listenTo App.vent, 'editChallenge', @editChallenge

  setModel: (model) ->
    if @model?
      @stopListening @model

    @model = model
    @listenTo @model, 'change', @render

  createChallenge: (e) ->
    e.preventDefault()

  editChallenge: (model) ->
    @setModel model
    @render()

module.exports = NewChallenge