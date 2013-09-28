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
		@listenTo App.vent, 'search:challenges', @matchSearch
		@listenTo @model, 'change', @render

	handleAction: (action) ->
		selected = @ui.checkbox.is ':checked'
		return unless selected

		switch action
			when 'lock' then @model.save locked:true, patch:true
			when 'unlock' then @model.save locked:false, patch:true
			when 'remove' then @model.destroy()

	matchSearch: (searchTerm) ->
		regex = new RegExp searchTerm

		for attr of _.omit @model.attributes, 'id'
			attribute = @model.get(attr).toString().toLowerCase()
			match = attribute.match regex

			break if match?

		unless match
			@$el.hide()
		else
			@$el.show()

	editMe: ->
		App.vent.trigger 'challenges:edit', @model

	check: (e) ->
		e.stopPropagation()

	removeMe: ->
		do @close

module.exports = ChallengeRow
