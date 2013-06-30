template = require './templates/challengesLayout'

class ChallengesLayout extends Backbone.Marionette.ItemView
	id: 'challenges-layout'
	template: template
	
	regions: {}

module.exports = ChallengesLayout

