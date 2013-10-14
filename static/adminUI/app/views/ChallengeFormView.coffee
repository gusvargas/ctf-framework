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
    'click .close-edit': 'closeEdit'

  modelEvents:
    'change': 'render'

  serializeData: ->
    context = {}
    editing = @model?

    if editing
      _.extend context, @model.toJSON(), {editing:editing}

    context

  onRender: ->
    @ui.name.focus()

  setModel: (model) ->
    if @model?
      @stopListening @model

    @model = model
    return if model is undefined

    @listenTo @model, 'change', @render

  submit: (e) ->
    e.preventDefault()
    editing = @model?

    attrs =
      name: @ui.name.val()
      category: @ui.category.val()
      points: parseInt @ui.points.val()
      target: @ui.target.val()
      description: @ui.description.val()
      flag: @ui.flag.val()
      locked: if @ui.locked.is(':checked') then 1 else 0

    if editing
      for attr, val of attrs
        if val is @model.get attr
          delete attrs[attr]

      @updateChallenge attrs
    else
      @createNewChallenge attrs
      @resetForm()

  createNewChallenge: (attrs) ->
    @collection.create attrs, {wait:true}

  updateChallenge: (attrs) ->
    unless _.isEmpty attrs
      @model.save attrs,
        wait: true
        patch: true

    @closeEdit()

  editChallenge: (model) ->
    @setModel model
    @render()

  closeEdit: (e) ->
    App.vent.trigger 'challenges:edit:close'

    @setModel undefined
    @render()

  resetForm: ->
    @ui.form[0].reset()

module.exports = ChallengeForm
