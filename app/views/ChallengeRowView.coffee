Challenge = require 'models/Challenge'
template = require 'views/templates/challengeRow'
App = require 'application'

class ChallengeRow extends Backbone.Marionette.ItemView
	model: Challenge
	template: template
	tagName: 'tr'

	ui:
		checkbox: 'input[type="checkbox"]'

	events:
		'click': 'editMe'
		'click input[type="checkbox"]': 'check'

	modelEvents:
		'destroy': 'removeMe'

	initialize: ->
		@listenTo App.vent, 'toolbar:action', @handleAction
		@listenTo @model, 'change', @render

	handleAction: (action) ->
		selected = @ui.checkbox.is ':checked'
		return unless selected

		switch action
			when 'lock' then @model.save locked:true, patch:true
			when 'unlock' then @model.save locked:false, patch:true
			when 'remove' then @model.destroy()

	editMe: ->
		App.vent.trigger 'challenges:edit', @model

	check: (e) ->
		e.stopPropagation()

	removeMe: ->
		do @close

module.exports = ChallengeRow
