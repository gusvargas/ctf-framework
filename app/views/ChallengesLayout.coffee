template = require './templates/challengesLayout'

class ChallengesLayout extends Backbone.Marionette.Layout
	id: 'challenges-layout'
	template: template
	
	regions:
		sideBar: '#challenges-sidebar'
		challenges: '#challanges-container'

module.exports = ChallengesLayout

