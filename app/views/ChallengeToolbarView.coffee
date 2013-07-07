template = require 'views/templates/challengeToolbar'
App = require 'application'

class ChallengeToolbar extends Backbone.Marionette.ItemView
	template: template
	className: 'toolbar'

	events:
		'click .toolbar-btn': 'performAction'

	performAction: (e) ->
		action = $(e.currentTarget).data 'action'
		App.vent.trigger 'toolbar:action', action

module.exports = ChallengeToolbar