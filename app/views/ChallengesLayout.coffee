template = require './templates/challengesLayout'

class ChallengesLayout extends Backbone.Marionette.ItemView
	id: 'challenges-container'
	template: template
	
	regions: {}

module.exports = ChallengesLayout

