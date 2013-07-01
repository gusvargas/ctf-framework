Challenge = require 'models/Challenge'
template = require 'views/templates/challengeRow'

class ChallengeRow extends Backbone.Marionette.ItemView
	model: Challenge
	template: template
	tagName: 'tr'

module.exports = ChallengeRow
