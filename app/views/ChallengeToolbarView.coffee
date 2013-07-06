template = require 'views/templates/challengeToolbar'

class ChallengeToolbar extends Backbone.Marionette.ItemView
	template: template
	className: 'toolbar'

module.exports = ChallengeToolbar