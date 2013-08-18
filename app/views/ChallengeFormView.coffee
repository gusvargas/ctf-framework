template = require 'views/templates/challengeForm'
Challenge = require 'models/Challenge'
App = require 'application'

class ChallengeForm extends Backbone.Marionette.ItemView
  template: template
  className: 'new-challenge-form'

  ui:
    form: 'form'
    name: '#challenge-name'
    category: '#challenge-category'
    points: '#challenge-points'
    target: '#challenge-target'
    description: '#challenge-desc'
    flag: '#challenge-flag'
    locked: '#challenge-locked'

  events:
    'click button': 'submit'

  serializeData: ->
    context = {}
    editing = @model?

    if editing
      _.extend context, @model.toJSON(), {editing:editing}

    context

  onRender: ->
    @ui.form
      .find('input')
      .first()
      .focus()

  initialize: ->
    @listenTo App.vent, 'editChallenge', @editChallenge

  setModel: (model) ->
    if @model?
      @stopListening @model

    @model = model
    @listenTo @model, 'change', @render

  submit: (e) ->
    e.preventDefault()
    editing = @model?

    attrs =
      name: @ui.name.val()
      category: @ui.category.val()
      points: @ui.points.val()
      target: @ui.target.val()
      description: @ui.description.val()
      locked: @ui.locked.is(':checked')

    if editing
      @updateChallenge attrs
    else
      @createNewChallenge attrs

  createNewChallenge: (attrs) ->
    @collection.create attrs, {wait:true}

  updateChallenge: (attrs) ->
    @model.save attrs, {wait:true}

  editChallenge: (model) ->
    @setModel model
    @render()

module.exports = ChallengeForm