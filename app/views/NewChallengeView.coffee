template = require 'views/templates/newChallenge'

class NewChallenge extends Backbone.Marionette.ItemView
	template: template
	className: 'new-challenge-form'

	events:
		'click button': 'createChallenge'

	createChallenge: (e) ->
		e.preventDefault()

module.exports = NewChallenge